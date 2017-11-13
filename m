From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:26 +0100
Subject: [PATCH v2 7/8] soc: actions: sps: Add S700
In-Reply-To: <20171113233427.5386-1-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
Message-ID: <20171113233427.5386-8-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power domains for S700 SoC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 drivers/soc/actions/owl-sps.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index 875225bfa21c..8477f0f18e24 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
@@ -17,6 +17,7 @@
 #include <linux/pm_domain.h>
 #include <linux/soc/actions/owl-sps.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/power/owl-s700-powergate.h>
 
 struct owl_sps_domain_info {
 	const char *name;
@@ -203,8 +204,49 @@ static const struct owl_sps_info s500_sps_info = {
 	.domains = s500_sps_domains,
 };
 
+static const struct owl_sps_domain_info s700_sps_domains[] = {
+	[S700_PD_VDE] = {
+		.name = "VDE",
+		.pwr_bit = 0,
+	},
+	[S700_PD_VCE_SI] = {
+		.name = "VCE_SI",
+		.pwr_bit = 1,
+	},
+	[S700_PD_USB2_1] = {
+		.name = "USB2_1",
+		.pwr_bit = 2,
+	},
+	[S700_PD_HDE] = {
+		.name = "HDE",
+		.pwr_bit = 7,
+	},
+	[S700_PD_DMA] = {
+		.name = "DMA",
+		.pwr_bit = 8,
+	},
+	[S700_PD_DS] = {
+		.name = "DS",
+		.pwr_bit = 9,
+	},
+	[S700_PD_USB3] = {
+		.name = "USB3",
+		.pwr_bit = 10,
+	},
+	[S700_PD_USB2_0] = {
+		.name = "USB2_0",
+		.pwr_bit = 11,
+	},
+};
+
+static const struct owl_sps_info s700_sps_info = {
+	.num_domains = ARRAY_SIZE(s700_sps_domains),
+	.domains = s700_sps_domains,
+};
+
 static const struct of_device_id owl_sps_of_matches[] = {
 	{ .compatible = "actions,s500-sps", .data = &s500_sps_info },
+	{ .compatible = "actions,s700-sps", .data = &s700_sps_info },
 	{ }
 };
 
-- 
2.13.6
