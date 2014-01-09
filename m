From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 9 Jan 2014 09:37:06 -0500
Subject: [PATCH] ARM: keystone: config: fix build warning when
 CONFIG_DMADEVICES is not set
Message-ID: <1389278226-23071-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Drop automatic selection of TI_EDMA from Keystone Kconfig file,
as it produces build warning in case if CONFIG_DMADEVICES is not set:

warning: (ARCH_KEYSTONE) selects TI_EDMA which has unmet direct dependencies (DMADEVICES && (ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE))

Instead enable TI EDMA support from defconfig.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---

Kevin, Olof, Arnd,

Please let me know if you can pick this patch in 3.14 arm-soc
queue or you prefer a pull request for the same. It applies against
'next/soc' cleanly.

Regards,
Santosh

 arch/arm/configs/keystone_defconfig |    1 +
 arch/arm/mach-keystone/Kconfig      |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index a018244..4582e16 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -142,6 +142,7 @@ CONFIG_USB_DWC3_DEBUG=y
 CONFIG_USB_DWC3_VERBOSE=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_DMADEVICES=y
+CONFIG_TI_EDMA=y
 CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_MEMORY=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index dabc5ee..90a708f 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -10,7 +10,6 @@ config ARCH_KEYSTONE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
-	select TI_EDMA
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
 	help
-- 
1.7.9.5
