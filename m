From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 10 Oct 2017 14:32:12 -0600
Subject: [PATCH 1/2] coresight: Extend the PIDR mask to cover relevant bits in
 PIDR2
In-Reply-To: <1507667533-21707-1-git-send-email-mathieu.poirier@linaro.org>
References: <1507667533-21707-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1507667533-21707-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
index accc2056f7c6..8f4357e2626c 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -199,8 +199,8 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 
 static const struct amba_id replicator_ids[] = {
 	{
-		.id     = 0x0003b909,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb909,
+		.mask   = 0x000fffff,
 	},
 	{
 		/* Coresight SoC-600 */
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 56ecd7aff5eb..e03e58933141 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -748,8 +748,8 @@ static const struct dev_pm_ops etb_dev_pm_ops = {
 
 static const struct amba_id etb_ids[] = {
 	{
-		.id	= 0x0003b907,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb907,
+		.mask	= 0x000fffff,
 	},
 	{ 0, 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index e5b1ec57dbde..39f42fdd503d 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -901,33 +901,33 @@ static const struct dev_pm_ops etm_dev_pm_ops = {
 
 static const struct amba_id etm_ids[] = {
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
index 77642e0e955b..fd3c396717f6 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -248,8 +248,8 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
 
 static const struct amba_id funnel_ids[] = {
 	{
-		.id     = 0x0003b908,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb908,
+		.mask   = 0x000fffff,
 	},
 	{
 		/* Coresight SoC-600 */
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 92a780a6df1d..15e7ef3891f5 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -917,13 +917,13 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
 
 static const struct amba_id stm_ids[] = {
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
index 2ff4a66a3caa..0ea04f588de0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -439,8 +439,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 static const struct amba_id tmc_ids[] = {
 	{
-		.id     = 0x0003b961,
-		.mask   = 0x0003ffff,
+		.id     = 0x000bb961,
+		.mask   = 0x000fffff,
 	},
 	{
 		/* Coresight SoC 600 TMC-ETR/ETS */
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index d7a3e453016d..bef49a3a5ca7 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -194,8 +194,8 @@ static const struct dev_pm_ops tpiu_dev_pm_ops = {
 
 static const struct amba_id tpiu_ids[] = {
 	{
-		.id	= 0x0003b912,
-		.mask	= 0x0003ffff,
+		.id	= 0x000bb912,
+		.mask	= 0x000fffff,
 	},
 	{
 		.id	= 0x0004b912,
-- 
2.7.4
