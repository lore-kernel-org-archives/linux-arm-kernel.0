From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 6 Nov 2012 14:15:14 +0100
Subject: [PATCH 2/9] ARM: ux500: 8500: add IDLE pin configuration for SPI
Message-ID: <1352207714-7848-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

This adds an idle state to the SPI pin control entry.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 8ab8688..9c9e465 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -70,6 +70,9 @@ BIAS(slpm_in_nopull_wkup_pdis, PIN_SLEEPMODE_ENABLED|PIN_SLPM_INPUT_NOPULL|PIN_S
 	PIN_MAP_MUX_GROUP_DEFAULT(dev, "pinctrl-db8500", group, func)
 #define DB8500_PIN(pin,conf,dev) \
 	PIN_MAP_CONFIGS_PIN_DEFAULT(dev, "pinctrl-db8500", pin, conf)
+#define DB8500_PIN_IDLE(pin, conf, dev) \
+	PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_IDLE, "pinctrl-db8500",	\
+			    pin, conf)
 #define DB8500_PIN_SLEEP(pin, conf, dev) \
 	PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_SLEEP, "pinctrl-db8500",	\
 			    pin, conf)
@@ -242,7 +245,12 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_PIN("GPIO218_AH11", in_pd, "spi2"), /* RXD */
 	DB8500_PIN("GPIO215_AH13", out_lo, "spi2"), /* TXD */
 	DB8500_PIN("GPIO217_AH12", out_lo, "spi2"), /* CLK */
+	/* SPI2 idle state */
+	DB8500_PIN_SLEEP("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
+	DB8500_PIN_SLEEP("GPIO215_AH13", slpm_out_lo_wkup_pdis, "spi2"), /* TXD */
+	DB8500_PIN_SLEEP("GPIO217_AH12", slpm_wkup_pdis, "spi2"), /* CLK */
 	/* SPI2 sleep state */
+	DB8500_PIN_SLEEP("GPIO216_AG12", slpm_in_wkup_pdis, "spi2"), /* FRM */
 	DB8500_PIN_SLEEP("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
 	DB8500_PIN_SLEEP("GPIO215_AH13", slpm_out_lo_wkup_pdis, "spi2"), /* TXD */
 	DB8500_PIN_SLEEP("GPIO217_AH12", slpm_wkup_pdis, "spi2"), /* CLK */
-- 
1.7.11.3
