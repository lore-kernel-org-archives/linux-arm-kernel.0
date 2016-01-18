From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Mon, 18 Jan 2016 16:38:31 +0100
Subject: [PATCH] pinctrl: st: activate strict mux mode
Message-ID: <1453131511-5590-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This activates strict mode muxing for the ST pin controllers,
as these do not allow GPIO and functions to use the same pin
simultaneously.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index b58d3f2..00e179b 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -988,6 +988,7 @@ static struct pinmux_ops st_pmxops = {
 	.get_function_groups	= st_pmx_get_groups,
 	.set_mux		= st_pmx_set_mux,
 	.gpio_set_direction	= st_pmx_set_gpio_direction,
+	.strict			= true,
 };
 
 /* Pinconf  */
-- 
1.9.1
