From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Jul 2014 23:25:08 +0800
Subject: [PATCH] pinctrl: sunxi: Remove gpio_out function from sun5i-a13
 PG0/1/2 pins
Message-ID: <1404228308-22783-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13 user manual states pins PG0/1/2 only have GPIO input and
interrupt functions. Remove the gpio_out functions for these pins.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Hi,

The A13 manual [1] and reference design [2] explicitly warn that pins
PG0/1/2 can not be used as gpio outputs. This patch removes the output
functions from the pin definitions.


ChenYu

[1] http://dl.linux-sunxi.org/A13/A13%20User%20Manual%20-%20v1.2%20%282013-01-08%29.pdf
    Page 384.
[2] https://github.com/OLIMEX/OLINUXINO/raw/master/HARDWARE/A13-PDFs/a13-sch.pdf
    Page 1, reminder in the red box (in Chinese)

---
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
index 29c734a..e47c33d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
@@ -330,15 +330,12 @@ static const struct sunxi_desc_pin sun5i_a13_pins[] = {
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_IRQ(0x6, 0)),		/* EINT0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_IRQ(0x6, 1)),		/* EINT1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION_IRQ(0x6, 2)),		/* EINT2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.0.0
