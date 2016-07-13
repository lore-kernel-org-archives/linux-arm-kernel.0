From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2016 12:26:51 +0100
Subject: [PATCH 3/3] mfd: db8500-prcmu: Example using new
 OF_MFD_CELL/MFD_CELL_BASIC MACROs
In-Reply-To: <20160713112651.14539-1-lee.jones@linaro.org>
References: <20160713112651.14539-1-lee.jones@linaro.org>
Message-ID: <20160713112651.14539-4-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... with and without 'resources'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index c0a86ae..4c9c951 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3061,29 +3061,16 @@ static const struct mfd_cell common_prcmu_devs[] = {
 };
 
 static const struct mfd_cell db8500_prcmu_devs[] = {
-	{
-		.name = "db8500-prcmu-regulators",
-		.of_compatible = "stericsson,db8500-prcmu-regulator",
-		.platform_data = &db8500_regulators,
-		.pdata_size = sizeof(db8500_regulators),
-	},
-	{
-		.name = "cpufreq-ux500",
-		.of_compatible = "stericsson,cpufreq-ux500",
-		.platform_data = &db8500_cpufreq_table,
-		.pdata_size = sizeof(db8500_cpufreq_table),
-	},
-	{
-		.name = "cpuidle-dbx500",
-		.of_compatible = "stericsson,cpuidle-dbx500",
-	},
-	{
-		.name = "db8500-thermal",
-		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
-		.resources = db8500_thsens_resources,
-		.platform_data = &db8500_thsens_data,
-		.pdata_size = sizeof(db8500_thsens_data),
-	},
+	OF_MFD_CELL("db8500-prcmu-regulators", NULL, &db8500_regulators,
+		    sizeof(db8500_regulators), 0,
+		    "stericsson,db8500-prcmu-regulator"),
+	OF_MFD_CELL("cpufreq-ux500", NULL, &db8500_cpufreq_table,
+		    sizeof(db8500_cpufreq_table), 0,
+		    "stericsson,cpufreq-ux500"),
+	OF_MFD_CELL("cpuidle-dbx500", NULL, NULL, 0, 0,
+		    "stericsson,cpuidle-dbx500"),
+	MFD_CELL_BASIC("db8500-thermal", db8500_thsens_resources,
+		       &db8500_thsens_data, sizeof(db8500_thsens_data), 0),
 };
 
 static void db8500_prcmu_update_cpufreq(void)
-- 
2.9.0
