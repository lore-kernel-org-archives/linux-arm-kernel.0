From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Apr 2014 22:10:21 +0200
Subject: [PATCH] pinctrl: capri: make Kconfig dependency more strict
Message-ID: <1396383021-2295-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is only useful on BCM281xx, so let the driver depend on
ARCH_BCM_MOBILE but allow compile coverage testing.
The main benefit is that the driver isn't available to be selected for
machines that don't have the matching hardware.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index e49324032611..072749816cb4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -106,7 +106,7 @@ config PINCTRL_BCM2835
 
 config PINCTRL_CAPRI
 	bool "Broadcom Capri pinctrl driver"
-	depends on OF
+	depends on OF && (ARCH_BCM_MOBILE || COMPILE_TEST)
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-- 
1.9.1
