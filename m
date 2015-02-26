From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Feb 2015 11:29:29 +0100
Subject: [PATCH] regulator: wm8350: remove unused variable
Message-ID: <2131808.TgSGZRWdu2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the only user of the variable has been removed, we get a valid gcc
warning about it:

regulator/wm8350-regulator.c:1154:17: warning: unused variable 'wm8350' [-Wunused-variable]

The obvious fix is to remove the variable as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 8f45acb5f9f34 ("regulator: wm8350: Pass NULL data with REGULATION_OUT and UNDER_VOLTAGE events")

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 78efead3b39f..95f6b040186e 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1151,7 +1151,6 @@ static const struct regulator_desc wm8350_reg[NUM_WM8350_REGULATORS] = {
 static irqreturn_t pmic_uv_handler(int irq, void *data)
 {
 	struct regulator_dev *rdev = (struct regulator_dev *)data;
-	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
 
 	mutex_lock(&rdev->mutex);
 	if (irq == WM8350_IRQ_CS1 || irq == WM8350_IRQ_CS2)
