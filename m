From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  6 Mar 2012 17:30:38 -0700
Subject: [PATCH 3/3] ARM: Allow the user to enable UIMAGE_KERNEL_NOLOAD
In-Reply-To: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1331080238-1524-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When AUTO_ZRELADDR is enabled, ARM zImages are relocatable, and hence
the user may use mkimage's -T kernel_noload option if their bootloader
supports it.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4040796..5459b2e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2055,6 +2055,7 @@ config CRASH_DUMP
 
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address"
+	select ALLOW_UIMAGE_KERNEL_NOLOAD
 	depends on !ZBOOT_ROM && !ARCH_U300
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
-- 
1.7.0.4
