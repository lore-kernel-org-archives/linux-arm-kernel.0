From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Tue, 14 Feb 2012 11:47:36 +0100
Subject: [PATCH] ux500: Remove keyboard pin definition for snowball
Message-ID: <1329216456-5569-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

Interfered with CG2900

Signed-off-by: Benn P?rscke <benn.porscke@stericsson.com>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index f8e7cd7..da17111 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -419,7 +419,6 @@ static struct ux500_pin_lookup mop500_pins[] = {
 	PIN_LOOKUP("nmk-i2c.1", &mop500_pins_i2c1),
 	PIN_LOOKUP("nmk-i2c.2", &mop500_pins_i2c2),
 	PIN_LOOKUP("nmk-i2c.3", &mop500_pins_i2c3),
-	PIN_LOOKUP("ske", &mop500_pins_ske),
 	PIN_LOOKUP("sdi0", &mop500_pins_sdi0),
 	PIN_LOOKUP("sdi1", &mop500_pins_sdi1),
 	PIN_LOOKUP("sdi2", &mop500_pins_sdi2),
@@ -428,6 +427,10 @@ static struct ux500_pin_lookup mop500_pins[] = {
 	PIN_LOOKUP("spi2", &mop500_pins_spi2),
 };
 
+static struct ux500_pin_lookup mop500_ske_pins[] = {
+	PIN_LOOKUP("ske", &mop500_pins_ske),
+};
+
 /*
  * Sleep pin configuration for u8500 platform.
  * If another HW is used the GPIO's must be configured
@@ -930,6 +933,7 @@ void __init mop500_pins_init(void)
 			ARRAY_SIZE(mop500_pins_common));
 
 	ux500_pins_add(mop500_pins, ARRAY_SIZE(mop500_pins));
+	ux500_pins_add(mop500_ske_pins, ARRAY_SIZE(mop500_ske_pins));
 
 	switch (pinsfor) {
 	case PINS_FOR_U9500:
@@ -971,6 +975,7 @@ void __init hrefv60_pins_init(void)
 			ARRAY_SIZE(mop500_pins_common));
 
 	ux500_pins_add(mop500_pins, ARRAY_SIZE(mop500_pins));
+	ux500_pins_add(mop500_ske_pins, ARRAY_SIZE(mop500_ske_pins));
 
 	nmk_config_pins(hrefv60_pins,
 			ARRAY_SIZE(hrefv60_pins));
-- 
1.7.6
