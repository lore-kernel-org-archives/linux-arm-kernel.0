From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 22 Nov 2012 11:35:40 +0100
Subject: [PATCH 2/2] mfd: ab8500-core: Add abx500-clk as an mfd child device
In-Reply-To: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
References: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1353580540-3774-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Hierarchically, the abx500-clk shall be considered as a child of the
ab8500 core. The abx500-clk is intiated at arch init and thus the clks
will be available when clients needs them.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mfd/ab8500-core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 1667c77..b8fe5f6f 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -984,6 +984,10 @@ static struct mfd_cell __devinitdata abx500_common_devs[] = {
 		.of_compatible = "stericsson,ab8500-regulator",
 	},
 	{
+		.name = "abx500-clk",
+		.of_compatible = "stericsson,abx500-clk",
+	},
+	{
 		.name = "ab8500-gpadc",
 		.of_compatible = "stericsson,ab8500-gpadc",
 		.num_resources = ARRAY_SIZE(ab8500_gpadc_resources),
-- 
1.7.10
