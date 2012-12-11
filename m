From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 11 Dec 2012 11:16:35 +0100
Subject: [PATCH] ARM: ux500: u8500: fix pinctrl IDLE state definition for SPI2
Message-ID: <1355220995-32022-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Delacou <julien.delacou@stericsson.com>

The wrong macro was used so we didn't really create an
idle state for these pins.

Signed-off-by: Julien Delacou <julien.delacou@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 6679d8a..10f1441 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -319,9 +319,9 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_PIN("GPIO215_AH13", out_lo, "spi2"), /* TXD */
 	DB8500_PIN("GPIO217_AH12", out_lo, "spi2"), /* CLK */
 	/* SPI2 idle state */
-	DB8500_PIN_SLEEP("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
-	DB8500_PIN_SLEEP("GPIO215_AH13", slpm_out_lo_wkup_pdis, "spi2"), /* TXD */
-	DB8500_PIN_SLEEP("GPIO217_AH12", slpm_wkup_pdis, "spi2"), /* CLK */
+	DB8500_PIN_IDLE("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
+	DB8500_PIN_IDLE("GPIO215_AH13", slpm_out_lo_wkup_pdis, "spi2"), /* TXD */
+	DB8500_PIN_IDLE("GPIO217_AH12", slpm_wkup_pdis, "spi2"), /* CLK */
 	/* SPI2 sleep state */
 	DB8500_PIN_SLEEP("GPIO216_AG12", slpm_in_wkup_pdis, "spi2"), /* FRM */
 	DB8500_PIN_SLEEP("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
-- 
1.7.11.3
