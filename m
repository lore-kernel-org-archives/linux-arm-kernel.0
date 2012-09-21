From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 21 Sep 2012 16:22:52 +0200
Subject: [RFC PATCH 1/6] pinctrl: samsung: Hold OF node of pin bank in bank
 struct
In-Reply-To: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
References: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348237377-21299-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node pointer will be used in extensions added by patches that will
follow.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 2 ++
 drivers/pinctrl/pinctrl-samsung.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 03bf743..846b277 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -825,6 +825,8 @@ static int samsung_pinctrl_parse_dt_bank(struct samsung_pin_bank *bank,
 	if (!ret)
 		bank->pudpdn_width = val;
 
+	bank->of_node = np;
+
 	if (!of_find_property(np, "interrupt-controller", NULL)) {
 		bank->eint_type = EINT_TYPE_NONE;
 		return 0;
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index 72303f1..b7b74cc 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -111,6 +111,7 @@ struct samsung_pinctrl_drv_data;
  * @eint_type: type of the external interrupt supported by the bank.
  * @irq_base: starting controller local irq number of the bank.
  * @name: name to be prefixed for each pin in this pin bank.
+ * @of_node: node of pin bank in device tree
  */
 struct samsung_pin_bank {
 	u32		pctl_offset;
@@ -125,6 +126,8 @@ struct samsung_pin_bank {
 	u32		eint_offset;
 	u32		irq_base;
 	const char	*name;
+
+	struct device_node *of_node;
 };
 
 /**
-- 
1.7.12
