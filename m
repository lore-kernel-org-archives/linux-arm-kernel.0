From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:29:12 +0200
Subject: [PATCH] ARM: imx: Synertronixx scb9328 needs to select SOC_IMX1
Message-ID: <2223651.9m9to5aFxT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required for building a kernel that enables only
scb9328 and would not get the i.MX1 specific files
otherwise.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index eef9590..60661a4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -173,6 +173,7 @@ config ARCH_MX1ADS
 config MACH_SCB9328
 	bool "Synertronixx scb9328"
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX1
 	help
 	  Say Y here if you are using a Synertronixx scb9328 board
 
