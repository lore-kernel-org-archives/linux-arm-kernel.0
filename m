From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 29 Aug 2018 11:31:09 +0200
Subject: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Message-ID: <20180829093108.GB22065@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

mfd: ti-lmu: constify mfd_cell tables
    
Add const attribute to all mfd_cell structures.
    
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index cfb411c..990437e 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 
 struct ti_lmu_data {
-	struct mfd_cell *cells;
+	const struct mfd_cell *cells;
 	int num_cells;
 	unsigned int max_register;
 };
@@ -63,7 +63,7 @@ static void ti_lmu_disable_hw(struct ti_lmu *lmu)
 		gpio_set_value(lmu->en_gpio, 0);
 }
 
-static struct mfd_cell lm3532_devices[] = {
+static const struct mfd_cell lm3532_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3532,
@@ -78,7 +78,7 @@ static struct mfd_cell lm3532_devices[] = {
 	.of_compatible = "ti,lm363x-regulator",	\
 }						\
 
-static struct mfd_cell lm3631_devices[] = {
+static const struct mfd_cell lm3631_devices[] = {
 	LM363X_REGULATOR(LM3631_BOOST),
 	LM363X_REGULATOR(LM3631_LDO_CONT),
 	LM363X_REGULATOR(LM3631_LDO_OREF),
@@ -91,7 +91,7 @@ static struct mfd_cell lm3631_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3632_devices[] = {
+static const struct mfd_cell lm3632_devices[] = {
 	LM363X_REGULATOR(LM3632_BOOST),
 	LM363X_REGULATOR(LM3632_LDO_POS),
 	LM363X_REGULATOR(LM3632_LDO_NEG),
@@ -102,7 +102,7 @@ static struct mfd_cell lm3632_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3633_devices[] = {
+static const struct mfd_cell lm3633_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3633,
@@ -120,7 +120,7 @@ static struct mfd_cell lm3633_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3695_devices[] = {
+static const struct mfd_cell lm3695_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3695,
@@ -128,7 +128,7 @@ static struct mfd_cell lm3695_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3697_devices[] = {
+static const struct mfd_cell lm3697_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3697,

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/f1f7c8fe/attachment.sig>
