From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 14 Jul 2015 11:12:15 -0700
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
Message-ID: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A9 on at least BCM4708 SoCs are not LPAE capable, booting such a
kernel will result in the following:

Error: Kernel with LPAE support, but CPU does not support LPAE.

Restrict such SoCs to be built in a configuration that does not enable
ARM_LPAE.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 0ac9e4b3b265..153a660da004 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -38,6 +38,7 @@ config ARCH_BCM_CYGNUS
 config ARCH_BCM_5301X
 	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
 	select ARCH_BCM_IPROC
+	depends on !ARM_LPAE
 	help
 	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
 
-- 
2.1.0
