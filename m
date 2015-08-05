From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue,  4 Aug 2015 18:43:28 -0700
Subject: [PATCH] ARM: BCM: Enable ARM erratum 798181 for BRCMSTB
Message-ID: <1438739008-16718-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 04fcab32d3fa1d3f6afe97e0ab431c5572e07a2c ("ARM: 8111/1: Enable
erratum 798181 for Broadcom Brahma-B15") enables this erratum for
affected Broadcom Brahma-B15 CPUs when CONFIG_ARM_ERRATA_798181=y.
Let's make sure that config option is actually set.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 0ac9e4b3..eed8746 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -140,6 +140,7 @@ config ARCH_BCM_63XX
 config ARCH_BRCMSTB
 	bool "Broadcom BCM7XXX based boards" if ARCH_MULTI_V7
 	select ARM_GIC
+	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
-- 
1.9.1
