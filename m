From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 24 Apr 2012 17:48:18 +0200
Subject: [PATCH v2 2/2] arm: imx: add missing select IMX_HAVE_PLATFORM for
 MACH_MX35_3DS in Kconfig
In-Reply-To: <1335282498-15896-1-git-send-email-mkl@pengutronix.de>
References: <1335282498-15896-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1335282498-15896-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following linker error:
arch/arm/mach-imx/built-in.o: In function `mx35_3ds_init':
mach-mx35_3ds.c:(.init.text+0x4b0): undefined reference to `imx_add_ipu_core'
mach-mx35_3ds.c:(.init.text+0x4c4): undefined reference to `imx_alloc_mx3_camera'
mach-mx35_3ds.c:(.init.text+0x520): undefined reference to `imx_add_mx3_sdc_fb'
mach-mx35_3ds.c:(.init.text+0x590): undefined reference to `imx35_ipu_core_data'

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
---

Changes since v1:
* don't select IMX_HAVE_PLATFORM_MX2_CAMERA (thanks Fabio)

 arch/arm/mach-imx/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7561eca..f72d399 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -571,8 +571,10 @@ config MACH_MX35_3DS
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-- 
1.7.4.1
