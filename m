From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  3 Nov 2014 11:05:25 -0800
Subject: [PATCH 1/7] pinctrl: pinconf-generic: Declare dt_params/conf_items
 const
In-Reply-To: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1415041531-15520-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/pinctrl/pinconf-generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index e28ef957ca2d..f78b416d7984 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -38,7 +38,7 @@ struct pin_config_item {
 #define PCONFDUMP(a, b, c, d) { .param = a, .display = b, .format = c, \
 				.has_arg = d }
 
-static struct pin_config_item conf_items[] = {
+static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_BUS_HOLD, "input bias bus hold", NULL, false),
@@ -159,7 +159,7 @@ struct pinconf_generic_dt_params {
 	u32 default_value;
 };
 
-static struct pinconf_generic_dt_params dt_params[] = {
+static const struct pinconf_generic_dt_params dt_params[] = {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
 	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
@@ -209,7 +209,7 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
-		struct pinconf_generic_dt_params *par = &dt_params[i];
+		const struct pinconf_generic_dt_params *par = &dt_params[i];
 		ret = of_property_read_u32(np, par->property, &val);
 
 		/* property not found */
-- 
1.9.1
