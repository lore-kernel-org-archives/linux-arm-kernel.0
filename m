From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2018 13:57:00 +0200
Subject: [PATCH] ARM: s3c24xx: jive: Fix some GPIO names
Message-ID: <20180423115700.13038-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the bitbanged SPI hosts had wrongly named GPIO lines due to
sloppiness by yours truly.

Cc: arm at kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC people:
Please apply this directly for fixes if it is OK with
everyone.
---
 arch/arm/mach-s3c24xx/mach-jive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 59589a4a0d4b..885e8f12e4b9 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -427,9 +427,9 @@ static struct gpiod_lookup_table jive_wm8750_gpiod_table = {
 	.dev_id         = "spi_gpio",
 	.table          = {
 		GPIO_LOOKUP("GPIOB", 4,
-			    "gpio-sck", GPIO_ACTIVE_HIGH),
+			    "sck", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOB", 9,
-			    "gpio-mosi", GPIO_ACTIVE_HIGH),
+			    "mosi", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("GPIOH", 10,
 			    "cs", GPIO_ACTIVE_HIGH),
 		{ },
-- 
2.14.3
