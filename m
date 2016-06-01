From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 20:35:24 +0300
Subject: [PATCH 3/5] ARM: OMAP5: control: add support for control module wkup
 pad config
In-Reply-To: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
References: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464802526-16372-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Match the new compatible string in the control module driver. The base
infra maps the required syscon ranges and clock registers if available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 50875d0..5956641 100644
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
1.9.1
