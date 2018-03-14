From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Mar 2018 15:53:13 +0200
Subject: [PATCH v2 4/6] ARM: OMAP5: control: add support for control module
 wkup pad config
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Message-ID: <20180314135315.11215-5-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Match the new compatible string in the control module driver. The base
infra maps the required syscon ranges and clock registers if available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/control.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 632adb2b7d03..180da403639e 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -636,6 +636,10 @@ static const struct control_init_data omap2_ctrl_data = {
 	.offset = -OMAP2_CONTROL_GENERAL,
 };
 
+static const struct control_init_data ctrl_aux_data = {
+	.index = TI_CLKM_CTRL_AUX,
+};
+
 static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
@@ -645,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
 	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
+	{ .compatible = "ti,omap5-scm-wkup-pad-conf", .data = &ctrl_aux_data },
 	{ .compatible = "ti,dra7-scm-core", .data = &ctrl_data },
 	{ }
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
