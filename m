From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  3 Jun 2014 10:02:36 +0200
Subject: [PATCH v2] pinctrl: hide CONFIG_PINMUX and CONFIG_PINCONF
Message-ID: <1401782556-5210-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These symbols are supposed to be selected by the drivers actually needing
them. The only situation where it would make sense to enable them without a
driver selecting them is when an out-of-tree pinctrl driver is used or
for compile testing.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since v1:
  - allow enabling with COMPILE_TEST

 drivers/pinctrl/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 33f9dc1f14fd..5f1af97a054b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -11,10 +11,10 @@ menu "Pin controllers"
 	depends on PINCTRL
 
 config PINMUX
-	bool "Support pin multiplexing controllers"
+	bool "Support pin multiplexing controllers" if COMPILE_TEST
 
 config PINCONF
-	bool "Support pin configuration controllers"
+	bool "Support pin configuration controllers" if COMPILE_TEST
 
 config GENERIC_PINCONF
 	bool
-- 
2.0.0
