From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:06:35 +0200
Subject: [PATCH 2/3] mfd: axp209x: Drop the parent supplies field
In-Reply-To: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1411243596-15117-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the regulator code get its parent supplies purely from the DT, we can
drop the parent supplies resources in the MFD driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dee653989e3a..6231adbb295d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -140,15 +140,6 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
 	.init_ack_masked	= true,
 };
 
-static const char * const axp20x_supplies[] = {
-	"acin",
-	"vin2",
-	"vin3",
-	"ldo24in",
-	"ldo3in",
-	"ldo5in",
-};
-
 static struct mfd_cell axp20x_cells[] = {
 	{
 		.name			= "axp20x-pek",
@@ -156,8 +147,6 @@ static struct mfd_cell axp20x_cells[] = {
 		.resources		= axp20x_pek_resources,
 	}, {
 		.name			= "axp20x-regulator",
-		.parent_supplies	= axp20x_supplies,
-		.num_parent_supplies	= ARRAY_SIZE(axp20x_supplies),
 	},
 };
 
-- 
2.1.0
