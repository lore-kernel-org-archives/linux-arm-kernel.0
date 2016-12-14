From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Wed, 14 Dec 2016 15:24:16 +0100
Subject: [PATCH] pinctrl: stm32: activate strict mux mode
Message-ID: <1481725456-1030-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This activates strict mode muxing for the STM32 pin controllers,
as these do not allow GPIO and functions to use the same pin
simultaneously.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index efc4371..c983a1e 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -631,6 +631,7 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	.get_function_groups	= stm32_pmx_get_func_groups,
 	.set_mux		= stm32_pmx_set_mux,
 	.gpio_set_direction	= stm32_pmx_gpio_set_direction,
+	.strict			= true,
 };
 
 /* Pinconf functions */
-- 
1.9.1
