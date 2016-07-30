From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 30 Jul 2016 16:20:22 +0200
Subject: [PATCH] pinctrl: sun6i: add SPDIF to pin description.
Message-ID: <20160730142022.29205-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF mux functionality to the pinctrl for the Allwinner A31
SoC.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 022863a..a70b529 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -896,10 +896,18 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out")),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 27),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		/*
+		 * The SPDIF block is not referenced at all in the A31 user
+		 * manual. However it is described in the code leaked and the
+		 * configuration files supplied by vendors.
+		 */
+		  SUNXI_FUNCTION(0x3, "spdif")),        /* SPDIF IN */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 28),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-		  SUNXI_FUNCTION(0x1, "gpio_out")),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		/* Undocumented mux function - see above */
+		  SUNXI_FUNCTION(0x3, "spdif")),        /* SPDIF OUT */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 29),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.9.2
