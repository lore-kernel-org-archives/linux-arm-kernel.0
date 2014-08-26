From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 14:23:57 +0900
Subject: [PATCH 3/8] ARM: shmobile: r8a7740: add MSTP clock assignments to DT
In-Reply-To: <cover.1409030383.git.horms+renesas@verge.net.au>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
Message-ID: <4a7ae2e27e18cbbdd83fb7783cd62abb4a62f33b.1409030383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Assigns clocks to ether, i2c*, scif*, tpu, mmcif0, sdhi*, and fsi2.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 3c61c5d..6cd6a46 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -126,7 +126,7 @@
 		reg = <0xe9a00000 0x800>,
 		      <0xe9a01800 0x800>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
-		/* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */
+		clocks = <&mstp3_clks R8A7740_CLK_GETHER>;
 		phy-mode = "mii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -142,6 +142,7 @@
 			      0 202 IRQ_TYPE_LEVEL_HIGH
 			      0 203 IRQ_TYPE_LEVEL_HIGH
 			      0 204 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7740_CLK_IIC0>;
 		status = "disabled";
 	};
 
@@ -154,6 +155,7 @@
 			      0 71 IRQ_TYPE_LEVEL_HIGH
 			      0 72 IRQ_TYPE_LEVEL_HIGH
 			      0 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7740_CLK_IIC1>;
 		status = "disabled";
 	};
 
@@ -161,6 +163,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c40000 0x100>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -168,6 +172,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA1>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -175,6 +181,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -182,6 +190,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c70000 0x100>;
 		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA3>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -189,6 +199,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c80000 0x100>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA4>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -196,6 +208,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6cb0000 0x100>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA5>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -203,6 +217,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6cc0000 0x100>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA6>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -210,6 +226,8 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6cd0000 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA7>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -217,6 +235,8 @@
 		compatible = "renesas,scifb-r8a7740", "renesas,scifb";
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFB>;
+		clock-names = "sci_ick";
 		status = "disabled";
 	};
 
@@ -240,6 +260,7 @@
 	tpu: pwm at e6600000 {
 		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
 		reg = <0xe6600000 0x100>;
+		clocks = <&mstp3_clks R8A7740_CLK_TPU0>;
 		status = "disabled";
 		#pwm-cells = <3>;
 	};
@@ -249,6 +270,7 @@
 		reg = <0xe6bd0000 0x100>;
 		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH
 			      0 57 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7740_CLK_MMC>;
 		status = "disabled";
 	};
 
@@ -258,6 +280,7 @@
 		interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH
 			      0 118 IRQ_TYPE_LEVEL_HIGH
 			      0 119 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7740_CLK_SDHI0>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -269,6 +292,7 @@
 		interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH
 			      0 122 IRQ_TYPE_LEVEL_HIGH
 			      0 123 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7740_CLK_SDHI1>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -280,6 +304,7 @@
 		interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH
 			      0 126 IRQ_TYPE_LEVEL_HIGH
 			      0 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A7740_CLK_SDHI2>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -290,6 +315,7 @@
 		compatible = "renesas,fsi2-r8a7740", "renesas,sh_fsi2";
 		reg = <0xfe1f0000 0x400>;
 		interrupts = <0 9 0x4>;
+		clocks = <&mstp3_clks R8A7740_CLK_FSI>;
 		status = "disabled";
 	};
 
-- 
2.0.1
