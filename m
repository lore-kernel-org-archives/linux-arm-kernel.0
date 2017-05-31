From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 31 May 2017 11:10:43 +0200
Subject: [PATCH] pinctrl: stm32: remove useless check
Message-ID: <1496221843-10697-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no link between the number of elements of tab which contains all
pin desc (located in each pinctrl-stm32xxxx.c files) and the pin number
(defined in the tab).

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index d3c5f5d..8be7ebd 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -411,11 +411,6 @@ static int stm32_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		pin = STM32_GET_PIN_NO(pinfunc);
 		func = STM32_GET_PIN_FUNC(pinfunc);
 
-		if (pin >= pctl->match_data->npins) {
-			dev_err(pctl->dev, "invalid pin number.\n");
-			return -EINVAL;
-		}
-
 		if (!stm32_pctrl_is_function_valid(pctl, pin, func)) {
 			dev_err(pctl->dev, "invalid function.\n");
 			return -EINVAL;
-- 
1.9.1
