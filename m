From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 18 Sep 2012 12:09:46 +0200
Subject: [PATCH] ARM: ux500: fix spi2 pin group
Message-ID: <1347962986-12280-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

GPIO216_AG12 is configured as a gpio for SPI2, so select
the spi2_oc1_2 pin group instead of spi2_oc1_1

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Olof, Arnd:

Again I'd prefer to take this through the pinctrl tree if it's
OK with you. We are deploying pinctrl internally and ironing out
bugs as we test more and more use cases.
---
 arch/arm/mach-ux500/board-mop500-pins.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index f0affc3..a96b945 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -219,7 +219,7 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_MUX("usb_a_1", "usb", "musb-ux500.0"),
 	DB8500_PIN("GPIO257_AE29", out_hi, "musb-ux500.0"), /* STP */
 	/* Mux in SPI2 pins on the "other C1" altfunction */
-	DB8500_MUX("spi2_oc1_1", "spi2", "spi2"),
+	DB8500_MUX("spi2_oc1_2", "spi2", "spi2"),
 	DB8500_PIN("GPIO216_AG12", gpio_out_hi, "spi2"), /* FRM */
 	DB8500_PIN("GPIO218_AH11", in_pd, "spi2"), /* RXD */
 	DB8500_PIN("GPIO215_AH13", out_lo, "spi2"), /* TXD */
-- 
1.7.11.3
