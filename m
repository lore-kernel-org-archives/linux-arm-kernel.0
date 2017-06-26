From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Jun 2017 16:22:47 +0100
Subject: [PATCH v2 03/12] coresight: Extend the PIDR mask to cover relevant
 bits in PIDR2
In-Reply-To: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1498490576-1350-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per coresight standards, PIDR2 register has the following format :

 [2-0]	- JEP106_bits6to4
 [3]	- JEDEC, designer ID is specified by JEDEC.

However some of the drivers only use mask of 0x3 for the PIDR2 leaving
bits [3-2] unchecked, which could potentially match the component for
a different device altogether. This patch fixes the mask and the
corresponding id bits for the existing devices.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
I have not touched the TPIU ids for Ux500 (see commit: 4339b699),
as I don't have a platform to fix/correct the ids.
---
 .../coresight/coresight-dynamic-replicator.c       |  4 ++--
 drivers/hwtracing/coresight/coresight-etb10.c      |  4 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c      | 24 +++++++++++-----------
 drivers/hwtracing/coresight/coresight-funnel.c     |  4 ++--
 drivers/hwtracing/coresight/coresight-stm.c        |  8 ++++----
 drivers/hwtracing/coresight/coresight-tmc.c        |  4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  4 ++--
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 1675031..57babd8 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -177,8 +177,8 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 
 static struct amba_id replicator_ids[] = {
 	{
-		.id     = 0x0003b909,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb909,
+		.mask   = 0x000bffff,
 	},
 	{ 0, 0 },
 };
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d5b9642..be6f59c 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -730,8 +730,8 @@ static const struct dev_pm_ops etb_dev_pm_ops = {
 
 static struct amba_id etb_ids[] = {
 	{
-		.id	= 0x0003b907,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb907,
+		.mask	= 0x000fffff,
 	},
 	{ 0, 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index a51b6b6..1af7f9e 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -887,33 +887,33 @@ static const struct dev_pm_ops etm_dev_pm_ops = {
 
 static struct amba_id etm_ids[] = {
 	{	/* ETM 3.3 */
-		.id	= 0x0003b921,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb921,
+		.mask	= 0x000fffff,
 		.data	= "ETM 3.3",
 	},
 	{	/* ETM 3.5 - Cortex-A5 */
-		.id	= 0x0003b955,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb955,
+		.mask	= 0x000fffff,
 		.data	= "ETM 3.5",
 	},
 	{	/* ETM 3.5 */
-		.id	= 0x0003b956,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb956,
+		.mask	= 0x000fffff,
 		.data	= "ETM 3.5",
 	},
 	{	/* PTM 1.0 */
-		.id	= 0x0003b950,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb950,
+		.mask	= 0x000fffff,
 		.data	= "PTM 1.0",
 	},
 	{	/* PTM 1.1 */
-		.id	= 0x0003b95f,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb95f,
+		.mask	= 0x000fffff,
 		.data	= "PTM 1.1",
 	},
 	{	/* PTM 1.1 Qualcomm */
-		.id	= 0x0003006f,
-		.mask	= 0x0003ffff,
+		.id	= 0x000b006f,
+		.mask	= 0x000fffff,
 		.data	= "PTM 1.1",
 	},
 	{ 0, 0},
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 860fe6e..6f7f3d3 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -248,8 +248,8 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
 
 static struct amba_id funnel_ids[] = {
 	{
-		.id     = 0x0003b908,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb908,
+		.mask   = 0x000fffff,
 	},
 	{ 0, 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 93fc26f..1bcda80 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -916,13 +916,13 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
 
 static struct amba_id stm_ids[] = {
 	{
-		.id     = 0x0003b962,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb962,
+		.mask   = 0x000fffff,
 		.data	= "STM32",
 	},
 	{
-		.id	= 0x0003b963,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb963,
+		.mask	= 0x000fffff,
 		.data	= "STM500",
 	},
 	{ 0, 0},
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 8644887..eb0c7b3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -393,8 +393,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 static struct amba_id tmc_ids[] = {
 	{
-		.id     = 0x0003b961,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb961,
+		.mask   = 0x000fffff,
 	},
 	{ 0, 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 0673baf..59c1510 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -194,8 +194,8 @@ static const struct dev_pm_ops tpiu_dev_pm_ops = {
 
 static struct amba_id tpiu_ids[] = {
 	{
-		.id	= 0x0003b912,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb912,
+		.mask	= 0x000fffff,
 	},
 	{
 		.id	= 0x0004b912,
-- 
2.7.5
