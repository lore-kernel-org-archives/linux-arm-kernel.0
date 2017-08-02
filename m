From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:18 -0600
Subject: [PATCH 24/26] coresight: Add support for Coresight SoC 600 components
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-25-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add the peripheral ids for the Coresight SoC 600 TPIU, replicator
and funnel.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 5 +++++
 drivers/hwtracing/coresight/coresight-funnel.c             | 5 +++++
 drivers/hwtracing/coresight/coresight-tpiu.c               | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index b00ea2d7d13f..87bcf2123e66 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -202,6 +202,11 @@ static struct amba_id replicator_ids[] = {
 		.id     = 0x0003b909,
 		.mask   = 0x0003ffff,
 	},
+	{
+		/* Coresight SoC-600 */
+		.id     = 0x000bb9ec,
+		.mask   = 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 860fe6ef5632..e55851564273 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -251,6 +251,11 @@ static struct amba_id funnel_ids[] = {
 		.id     = 0x0003b908,
 		.mask   = 0x0003ffff,
 	},
+	{
+		/* Coresight SoC-600 */
+		.id     = 0x000bb9eb,
+		.mask   = 0x000fffff,
+	},
 	{ 0, 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 0673baf0f2f5..0e9d57e372bd 100644
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
