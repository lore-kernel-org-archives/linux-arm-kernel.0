From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:07 +0100
Subject: [PATCH 39/51] ARM: imx: let IMX_HAVE_PLATFORM_IMX_FB select
	HAVE_FB_IMX
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-39-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way FB_IMX can just depend on HAVE_FB_IMX and machines
just need to select IMX_HAVE_PLATFORM_IMX_FB without bothering
about HAVE_FB_IMX.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig         |    3 +--
 arch/arm/plat-mxc/devices/Kconfig |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4423df6..9e6093d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -17,9 +17,8 @@ config SOC_IMX21
 config SOC_IMX25
 	bool
 	select CPU_ARM926T
-	select ARCH_MXC_IOMUX_V3
-	select HAVE_FB_IMX
 	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MXC_IOMUX_V3
 
 config SOC_IMX27
 	bool
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 81d7a54..dbb2078 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -27,6 +27,7 @@ config IMX_HAVE_PLATFORM_IMXDI_RTC
 
 config IMX_HAVE_PLATFORM_IMX_FB
 	bool
+	select HAVE_FB_IMX
 
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
-- 
1.7.2.3
