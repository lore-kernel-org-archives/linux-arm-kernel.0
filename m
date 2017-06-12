From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Jun 2017 15:36:51 +0100
Subject: [PATCH 12/12] coresight: Add support for Coresight SoC 600 components
In-Reply-To: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1497278211-5001-13-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the peripheral ids for the Coresight SoC 600 TPIU, replicator
and funnel.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c          | 5 +++++
 drivers/hwtracing/coresight/coresight-replicator-qcom.c | 6 ++++++
 drivers/hwtracing/coresight/coresight-tpiu.c            | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 6f7f3d3..df1cf73 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -251,6 +251,11 @@ static struct amba_id funnel_ids[] = {
 		.id     = 0x000bb908,
 		.mask   = 0x000fffff,
 	},
+	{
+		/* Coresight SoC-600 */
+		.id     = 0x000bb9eb,
+		.mask   = 0x000fffff,
+	},
 	{ 0, 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index 4dd18e0..d09b124 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -202,6 +202,12 @@ static struct amba_id replicator_ids[] = {
 		.mask   = 0x000bffff,
 		.data	= "REPLICATOR 1.0",
 	},
+	{
+		/* Coresight SoC-600 */
+		.id     = 0x000bb9ec,
+		.mask   = 0x000fffff,
+		.data	= "REPLICATOR 1.0",
+	},
 	{ 0, 0 },
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59c1510..eda5d5a 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -201,6 +201,11 @@ static struct amba_id tpiu_ids[] = {
 		.id	= 0x0004b912,
 		.mask	= 0x0007ffff,
 	},
+	{
+		/* Coresight SoC-600 */
+		.id	= 0x000bb9e7,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0},
 };
 
-- 
2.7.4
