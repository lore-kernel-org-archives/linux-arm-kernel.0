From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 25 Mar 2013 13:11:14 +0900
Subject: [RFC PATCH 6/6] ARM, mm: enable NO_BOOTMEM for default ARM build
In-Reply-To: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1364184674-13798-7-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we use NO_BOOTMEM, we don't need to initialize a bitmap and
we don't need to do bitmap operation, so we can boot slightly faster.

Additionaly advantage of enabling NO_BOOTMEM is saving more memory.
bootmem allocator manage memories as page unit, so if we request
4 bytes area to bootmem, it actually give us PAGE_SIZE area.
nobootmem manage memory as byte unit, so there is no waste.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13b7394..8b73417 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -58,6 +58,7 @@ config ARM
 	select CLONE_BACKWARDS
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select NO_BOOTMEM
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
-- 
1.7.9.5
