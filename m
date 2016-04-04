From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:17 +0900
Subject: [PATCH 09/26] ARM: dts: alt: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <be7359dd9813e44bad827607048dd16298076bb8.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the alt device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index ca9bc4fff287..383ad791f1db 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -107,38 +107,38 @@
 	pinctrl-names = "default";
 
 	du_pins: du {
-		renesas,groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_dotclkout0";
-		renesas,function = "du";
+		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_dotclkout0";
+		function = "du";
 	};
 
 	scif2_pins: serial2 {
-		renesas,groups = "scif2_data";
-		renesas,function = "scif2";
+		groups = "scif2_data";
+		function = "scif2";
 	};
 
 	scif_clk_pins: scif_clk {
-		renesas,groups = "scif_clk";
-		renesas,function = "scif_clk";
+		groups = "scif_clk";
+		function = "scif_clk";
 	};
 
 	ether_pins: ether {
-		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
-		renesas,function = "eth";
+		groups = "eth_link", "eth_mdio", "eth_rmii";
+		function = "eth";
 	};
 
 	phy1_pins: phy1 {
-		renesas,groups = "intc_irq8";
-		renesas,function = "intc";
+		groups = "intc_irq8";
+		function = "intc";
 	};
 
 	i2c1_pins: i2c1 {
-		renesas,groups = "i2c1";
-		renesas,function = "i2c1";
+		groups = "i2c1";
+		function = "i2c1";
 	};
 
 	vin0_pins: vin0 {
-		renesas,groups = "vin0_data8", "vin0_clk";
-		renesas,function = "vin0";
+		groups = "vin0_data8", "vin0_clk";
+		function = "vin0";
 	};
 };
 
@@ -148,8 +148,8 @@
 
 &pfc {
 	qspi_pins: spi0 {
-		renesas,groups = "qspi_ctrl", "qspi_data4";
-		renesas,function = "qspi";
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
 	};
 };
 
-- 
2.1.4
