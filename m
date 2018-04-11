From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 11 Apr 2018 22:10:35 +0530
Subject: [PATCH 3/4] soc: actions: sps: Add S900 power domains
In-Reply-To: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180411164036.8046-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power domains for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/actions/owl-sps.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index 38b276e6f319..f6445d671f22 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
@@ -14,6 +14,7 @@
 #include <linux/soc/actions/owl-sps.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 #include <dt-bindings/power/owl-s700-powergate.h>
+#include <dt-bindings/power/owl-s900-powergate.h>
 
 struct owl_sps_domain_info {
 	const char *name;
@@ -240,9 +241,66 @@ static const struct owl_sps_info s700_sps_info = {
 	.domains = s700_sps_domains,
 };
 
+static const struct owl_sps_domain_info s900_sps_domains[] = {
+	[S900_PD_GPU_B] = {
+		.name = "GPU_B",
+		.pwr_bit = 3,
+	},
+	[S900_PD_VCE] = {
+		.name = "VCE",
+		.pwr_bit = 4,
+	},
+	[S900_PD_SENSOR] = {
+		.name = "SENSOR",
+		.pwr_bit = 5,
+	},
+	[S900_PD_VDE] = {
+		.name = "VDE",
+		.pwr_bit = 6,
+	},
+	[S900_PD_HDE] = {
+		.name = "HDE",
+		.pwr_bit = 7,
+	},
+	[S900_PD_USB3] = {
+		.name = "USB3",
+		.pwr_bit = 8,
+	},
+	[S900_PD_DDR0] = {
+		.name = "DDR0",
+		.pwr_bit = 9,
+	},
+	[S900_PD_DDR1] = {
+		.name = "DDR1",
+		.pwr_bit = 10,
+	},
+	[S900_PD_DE] = {
+		.name = "DE",
+		.pwr_bit = 13,
+	},
+	[S900_PD_NAND] = {
+		.name = "NAND",
+		.pwr_bit = 14,
+	},
+	[S900_PD_USB2_H0] = {
+		.name = "USB2_H0",
+		.pwr_bit = 15,
+	},
+	[S900_PD_USB2_H1] = {
+		.name = "USB2_H1",
+		.pwr_bit = 16,
+	},
+};
+
+static const struct owl_sps_info s900_sps_info = {
+	.num_domains = ARRAY_SIZE(s900_sps_domains),
+	.domains = s900_sps_domains,
+};
+
 static const struct of_device_id owl_sps_of_matches[] = {
 	{ .compatible = "actions,s500-sps", .data = &s500_sps_info },
 	{ .compatible = "actions,s700-sps", .data = &s700_sps_info },
+	{ .compatible = "actions,s900-sps", .data = &s900_sps_info },
 	{ }
 };
 
-- 
2.14.1
