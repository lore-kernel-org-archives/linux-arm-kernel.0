From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  7 May 2015 11:53:45 +0200
Subject: [PATCH 2/2] pinctrl: nomadik: activate strict mux mode
Message-ID: <1430992425-10818-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This activates strict mode muxing for the Nomadik pin controllers,
as these do not allow GPIO and functions to use the same pin
simultaneously.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c  | 1 +
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 23db4c9ac76c..15ccafd74dc6 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -787,6 +787,7 @@ static const struct pinmux_ops abx500_pinmux_ops = {
 	.set_mux = abx500_pmx_set,
 	.gpio_request_enable = abx500_gpio_request_enable,
 	.gpio_disable_free = abx500_gpio_disable_free,
+	.strict = true,
 };
 
 static int abx500_get_groups_cnt(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index a6a22054c0ba..0c57edb2b222 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1803,6 +1803,7 @@ static const struct pinmux_ops nmk_pinmux_ops = {
 	.set_mux = nmk_pmx_set,
 	.gpio_request_enable = nmk_gpio_request_enable,
 	.gpio_disable_free = nmk_gpio_disable_free,
+	.strict = true,
 };
 
 static int nmk_pin_config_get(struct pinctrl_dev *pctldev, unsigned pin,
-- 
1.9.3
