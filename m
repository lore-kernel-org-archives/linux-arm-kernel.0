From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 21 Feb 2014 15:05:26 +0100
Subject: [PATCH] phy: restrict Samsung S5P/Exynos drivers to the respective
 architectures
Message-ID: <1392991526-20895-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling these drivers on platforms not created by Samsung is useless
unless you're doing compile tests. So don't offer the users to enable
them without COMPILE_TEST for configs with S5P/Exynos disabled.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/phy/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index c7a551c2d5f1..82a98f1a5ec2 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -18,6 +18,7 @@ config GENERIC_PHY
 config PHY_EXYNOS_MIPI_VIDEO
 	depends on HAS_IOMEM
 	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
+	depends on PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
 	  and EXYNOS SoCs.
@@ -54,6 +55,7 @@ config TWL4030_USB
 config PHY_EXYNOS_DP_VIDEO
 	tristate "EXYNOS SoC series Display Port PHY driver"
 	depends on OF
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	select GENERIC_PHY
 	help
 	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
-- 
1.8.5.3
