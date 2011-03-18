From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 18 Mar 2011 12:24:08 +0100
Subject: [PATCH] ARM: imx: let MACH_IMX27_VISSTRIM_M10 select
	IMX_HAVE_PLATFORM_IMX_SSI
Message-ID: <1300447448-27482-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-imx27_visstrim_m10.c uses imx27_add_imx_ssi() so it needs to select
IMX_HAVE_PLATFORM_IMX_SSI to fix:

	arch/arm/mach-imx/built-in.o: In function `visstrim_m10_board_init':
	mach-imx27_visstrim_m10.c:(.init.text+0x308): undefined reference to `imx_add_imx_ssi'
	mach-imx27_visstrim_m10.c:(.init.text+0x394): undefined reference to `imx27_imx_ssi_data'

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c223458..6199317 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -281,6 +281,7 @@ config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
 	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_EHCI
-- 
1.7.2.3
