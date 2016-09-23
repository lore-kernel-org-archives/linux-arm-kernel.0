From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 23 Sep 2016 10:28:40 +0200
Subject: [PATCH] ARM: shmobile: Sort Kconfig selections
Message-ID: <1474619320-28888-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort alphabetically all symbols selected by ARCH_RENESAS

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4a48c9f5f72537cd..b5a3cbe81dd1d1f0 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -33,15 +33,15 @@ config ARCH_RMOBILE
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_SHMOBILE
 	select ARCH_SHMOBILE_MULTI
+	select ARM_GIC
+	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select ARM_GIC
-	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select NO_IOPORT_MAP
 	select PINCTRL
-	select GPIOLIB
 	select ZONE_DMA if ARM_LPAE
 
 if ARCH_RENESAS
-- 
1.9.1
