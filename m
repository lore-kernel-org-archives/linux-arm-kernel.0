From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Apr 2014 22:25:59 +0200
Subject: [PATCH] pinctrl: msm8x74: make Kconfig dependency more strict
Message-ID: <1396383959-7445-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is only useful on MSM8x74, so let the driver depend on
ARCH_QCOM but allow compile coverage testing.
The main benefit is that the driver isn't available to be selected for
machines that don't have the matching hardware.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 072749816cb4..e493268062b6 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -224,7 +224,7 @@ config PINCTRL_MSM
 
 config PINCTRL_MSM8X74
 	tristate "Qualcomm 8x74 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on GPIOLIB && OF && (ARCH_QCOM || COMPILE_TEST)
 	select PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-- 
1.9.1
