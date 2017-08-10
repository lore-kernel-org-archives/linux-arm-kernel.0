From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 10 Aug 2017 12:06:17 +0200
Subject: [PATCH 05/17] pinctrl: sirf: atlas7: constify pinconf_ops, pinctrl_ops,
 and pinmux_ops structures
In-Reply-To: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502359589-15970-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pinmux_ops structure is only stored in the const pmxops field
of a pinctrl_desc structure. Make the pinmux_ops structure const as
well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/sirf/pinctrl-atlas7.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index d1ef82c..17c326c 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -5261,7 +5261,7 @@ static int atlas7_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static struct pinmux_ops atlas7_pinmux_ops = {
+static const struct pinmux_ops atlas7_pinmux_ops = {
 	.get_functions_count = atlas7_pmx_get_funcs_count,
 	.get_function_name = atlas7_pmx_get_func_name,
 	.get_function_groups = atlas7_pmx_get_func_groups,
