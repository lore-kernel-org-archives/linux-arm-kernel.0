From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 15:42:44 +0530
Subject: [PATCH 1/9] regulator: twl: Remove hardcoded board constraints from
	driver
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Message-ID: <1317118372-17052-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
each regulator from the twl driver and let the boards pass it.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/twl-regulator.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index ee8747f..f696287 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1027,14 +1027,6 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	/* copy the features into regulator data */
 	info->features = (unsigned long)initdata->driver_data;
 
-	/* Constrain board-specific capabilities according to what
-	 * this driver and the chip itself can actually do.
-	 */
-	c = &initdata->constraints;
-	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
-	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS;
 	switch (pdev->id) {
 	case TWL4030_REG_VIO:
 	case TWL4030_REG_VDD1:
-- 
1.7.1
