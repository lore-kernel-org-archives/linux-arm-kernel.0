From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 13 Jul 2017 11:12:43 +0200
Subject: [PATCH 2/2] pinctrl: zynq: Fix warnings in the driver
In-Reply-To: <4c6e1f9b0635682518d2ffa50cf611efef4aff68.1499937148.git.michal.simek@xilinx.com>
References: <4c6e1f9b0635682518d2ffa50cf611efef4aff68.1499937148.git.michal.simek@xilinx.com>
Message-ID: <4ec0134906b80ac107dfc80fbf7beb10e38e47cb.1499937148.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the below warning
        --> Prefer 'unsigned int' to bare use of 'unsigned'.
        --> line over 80 characters.
        --> Prefer 'unsigned int **' to bare use of 'unsigned **'.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/pinctrl/pinctrl-zynq.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 7565651acdc6..a0daf27042bd 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -62,7 +62,7 @@ struct zynq_pinctrl {
 struct zynq_pctrl_group {
 	const char *name;
 	const unsigned int *pins;
-	const unsigned npins;
+	const unsigned int npins;
 };
 
 /**
@@ -841,7 +841,7 @@ static int zynq_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *zynq_pctrl_get_group_name(struct pinctrl_dev *pctldev,
-					     unsigned selector)
+					     unsigned int selector)
 {
 	struct zynq_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
@@ -849,9 +849,9 @@ static const char *zynq_pctrl_get_group_name(struct pinctrl_dev *pctldev,
 }
 
 static int zynq_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
-				     unsigned selector,
-				     const unsigned **pins,
-				     unsigned *num_pins)
+				     unsigned int selector,
+				     const unsigned int **pins,
+				     unsigned int *num_pins)
 {
 	struct zynq_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
@@ -878,7 +878,7 @@ static int zynq_pmux_get_functions_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *zynq_pmux_get_function_name(struct pinctrl_dev *pctldev,
-					       unsigned selector)
+					       unsigned int selector)
 {
 	struct zynq_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
@@ -886,7 +886,7 @@ static const char *zynq_pmux_get_function_name(struct pinctrl_dev *pctldev,
 }
 
 static int zynq_pmux_get_function_groups(struct pinctrl_dev *pctldev,
-					 unsigned selector,
+					 unsigned int selector,
 					 const char * const **groups,
 					 unsigned * const num_groups)
 {
@@ -898,8 +898,8 @@ static int zynq_pmux_get_function_groups(struct pinctrl_dev *pctldev,
 }
 
 static int zynq_pinmux_set_mux(struct pinctrl_dev *pctldev,
-			       unsigned function,
-			       unsigned group)
+			       unsigned int function,
+			       unsigned int  group)
 {
 	int i, ret;
 	struct zynq_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -986,8 +986,8 @@ enum zynq_pin_config_param {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static const struct pin_config_item zynq_conf_items[ARRAY_SIZE(zynq_dt_params)] = {
-	PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
+static const struct pin_config_item zynq_conf_items[ARRAY_SIZE(zynq_dt_params)]
+	= { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
 };
 #endif
 
@@ -997,7 +997,7 @@ static unsigned int zynq_pinconf_iostd_get(u32 reg)
 }
 
 static int zynq_pinconf_cfg_get(struct pinctrl_dev *pctldev,
-				unsigned pin,
+				unsigned int pin,
 				unsigned long *config)
 {
 	u32 reg;
@@ -1054,9 +1054,9 @@ static int zynq_pinconf_cfg_get(struct pinctrl_dev *pctldev,
 }
 
 static int zynq_pinconf_cfg_set(struct pinctrl_dev *pctldev,
-				unsigned pin,
+				unsigned int pin,
 				unsigned long *configs,
-				unsigned num_configs)
+				unsigned int num_configs)
 {
 	int i, ret;
 	u32 reg;
@@ -1130,9 +1130,9 @@ static int zynq_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 }
 
 static int zynq_pinconf_group_set(struct pinctrl_dev *pctldev,
-				  unsigned selector,
+				  unsigned int selector,
 				  unsigned long *configs,
-				  unsigned num_configs)
+				  unsigned int  num_configs)
 {
 	int i, ret;
 	struct zynq_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-- 
1.9.1
