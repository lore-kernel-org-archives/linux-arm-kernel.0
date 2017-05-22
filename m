From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 14:25:49 +0800
Subject: [PATCH 3/6] pinctrl: sunxi: Fix SPDIF function name for A83T
In-Reply-To: <20170522062552.19026-1-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
Message-ID: <20170522062552.19026-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use well known standard names for functions that have name, such as
I2C, SPI, SPDIF, etc..

Fix the function name of SPDIF, which was named OWA (One Wire Audio)
based on Allwinner datasheets.

Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller
		      support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
index 9aec1d2232dd..6624499eae72 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -394,7 +394,7 @@ static const struct sunxi_desc_pin sun8i_a83t_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 18),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x3, "owa")),		/* DOUT */
+		  SUNXI_FUNCTION(0x3, "spdif")),	/* DOUT */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 19),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
-- 
2.11.0
