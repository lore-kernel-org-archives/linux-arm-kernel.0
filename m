From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 18 Jul 2017 10:48:15 +0100
Subject: [PATCH v4 18/18] coresight: Add support for Coresight SoC 600
 components
In-Reply-To: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
References: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500371295-30472-19-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the peripheral ids for the Coresight SoC 600 TPIU, replicator
and funnel.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 5 +++++
 drivers/hwtracing/coresight/coresight-funnel.c             | 5 +++++
 drivers/hwtracing/coresight/coresight-tpiu.c               | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 93c2206..1e4beb2 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -200,6 +200,11 @@ static struct amba_id replicator_ids[] = {
 		.id     = 0x000bb909,
 		.mask   = 0x000fffff,
 	},
+	{
+		/* Coresight SoC-600 */
+		.id     = 0x000bb9ec,
+		.mask   = 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
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
2.7.5
