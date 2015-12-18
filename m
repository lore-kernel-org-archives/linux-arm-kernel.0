From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 16:40:26 +0100
Subject: [PATCH] ARM: imx: select SRC for i.MX7
Message-ID: <3611827.5qPn4xd4c4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX7 Kconfig option had a couple of missing select lines that
I fixed already, but I missed HAVE_IMX_SRC:

arch/arm/mach-imx/built-in.o: In function `imx7d_init_irq':
platform-spi_imx.c:(.init.text+0x25a8): undefined reference to `imx_src_init'

This adds that one as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0be5da9dc249 ("ARM: imx: imx7d requires anatop")

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0ac180f7b330..15df34fbdf44 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -563,6 +563,7 @@ config SOC_IMX7D
 	select ARM_GIC
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
+	select HAVE_IMX_SRC
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
