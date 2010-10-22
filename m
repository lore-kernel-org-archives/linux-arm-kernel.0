From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 22 Oct 2010 11:27:08 +0200
Subject: [PATCH] imx: only select HAVE_CAN_FLEXCAN if CAN is enabled
Message-ID: <1287739628-330-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a warning

	warning: (IMX_HAVE_PLATFORM_FLEXCAN && ARCH_MXC) selects HAVE_CAN_FLEXCAN which has unmet direct dependencies (NET && CAN)

(The warning in general exists since

	246cf9c (kbuild: Warn on selecting symbols with unmet direct dependencies)

which was reverted between 71ebc01 and b1f7d6e.)

Reported-and-introduced-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 4047994..26e745b 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -6,7 +6,7 @@ config IMX_HAVE_PLATFORM_FEC
 	default y if ARCH_MX25 || SOC_IMX27 || ARCH_MX35 || ARCH_MX51
 
 config IMX_HAVE_PLATFORM_FLEXCAN
-	select HAVE_CAN_FLEXCAN
+	select HAVE_CAN_FLEXCAN if CAN
 	bool
 
 config IMX_HAVE_PLATFORM_IMX_I2C
-- 
1.7.2.3
