From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  2 Oct 2014 10:40:20 +0200
Subject: [PATCH 7/7] pinctrl: abx500: mark pin config as generic
In-Reply-To: <1412239220-22495-1-git-send-email-linus.walleij@linaro.org>
References: <1412239220-22495-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1412239220-22495-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is generic pin configuration, so add .is_generic.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 3b3fbb4c21c9..5b300d2d6bf8 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -1105,6 +1105,7 @@ out:
 static const struct pinconf_ops abx500_pinconf_ops = {
 	.pin_config_get = abx500_pin_config_get,
 	.pin_config_set = abx500_pin_config_set,
+	.is_generic = true,
 };
 
 static struct pinctrl_desc abx500_pinctrl_desc = {
-- 
1.9.3
