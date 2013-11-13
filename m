From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 13 Nov 2013 19:15:50 +0800
Subject: [PATCH 1/2] ARM: default PHYS_OFFSET if !MMU
In-Reply-To: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
References: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1384341351-4110-2-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

Set CONFIG_PAGE_OFFSET as PHYS_OFFSET when !MMU so that
we can keep CONFIG_PAGE_OFFSET same with PAGE_OFFSET.
 
This patch and patch 2/2 fix regression on !MMU by
f6537f2f0eba4eba("scripts/kallsyms: filter symbols not
in kernel address space")

Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 799ef94..db708c4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1560,6 +1560,7 @@ endchoice
 
 config PAGE_OFFSET
 	hex
+	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
 	default 0x80000000 if VMSPLIT_2G
 	default 0xC0000000
-- 
1.7.9.5
