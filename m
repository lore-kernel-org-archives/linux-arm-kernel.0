From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 10 Aug 2017 12:06:18 +0200
Subject: [PATCH 06/17] pinctrl: sirf: constify pinconf_ops, pinctrl_ops,
 and pinmux_ops structures
In-Reply-To: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502359589-15970-7-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These structures are only stored in fields of a pinctrl_desc
structure (pctlops and pmxops) that are const. Make the
structures const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/sirf/pinctrl-sirf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 80bfd47..d3ef059 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -133,7 +133,7 @@ static void sirfsoc_dt_free_map(struct pinctrl_dev *pctldev,
 	kfree(map);
 }
 
-static struct pinctrl_ops sirfsoc_pctrl_ops = {
+static const struct pinctrl_ops sirfsoc_pctrl_ops = {
 	.get_groups_count = sirfsoc_get_groups_count,
 	.get_group_name = sirfsoc_get_group_name,
 	.get_group_pins = sirfsoc_get_group_pins,
@@ -229,7 +229,7 @@ static int sirfsoc_pinmux_request_gpio(struct pinctrl_dev *pmxdev,
 	return 0;
 }
 
-static struct pinmux_ops sirfsoc_pinmux_ops = {
+static const struct pinmux_ops sirfsoc_pinmux_ops = {
 	.set_mux = sirfsoc_pinmux_set_mux,
 	.get_functions_count = sirfsoc_pinmux_get_funcs_count,
 	.get_function_name = sirfsoc_pinmux_get_func_name,
