From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 22:17:13 +0200
Subject: [PATCH 3/5] regulator: Fix ena_gpio check
In-Reply-To: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412626635-7404-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the introduced ena_gpio_valid field to check if ena_gpio stores a
valid gpio.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a3c3785901f5..fd683d26786c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3560,7 +3560,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	dev_set_drvdata(&rdev->dev, rdev);
 
-	if (config->ena_gpio && gpio_is_valid(config->ena_gpio)) {
+	if (config->ena_gpio_valid && gpio_is_valid(config->ena_gpio)) {
 		ret = regulator_ena_gpio_request(rdev, config);
 		if (ret != 0) {
 			rdev_err(rdev, "Failed to request enable GPIO%d: %d\n",
-- 
2.1.0
