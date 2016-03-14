From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 Mar 2016 11:29:03 +0900
Subject: [PATCH 2/2] ARM: dts: r8a7794: add CAN nodes to device tree
In-Reply-To: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
References: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1457922543-20975-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN nodes to r8a7794 device tree.

Based on work by Sergei Shtylyov for the r8a7791 SoC.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 22 ++++++++++++++++++++++
 include/dt-bindings/clock/r8a7794-clock.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index c8742a599330..ab755b754a9e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -830,6 +830,28 @@
 		};
 	};
 
+	can0: can at e6e80000 {
+		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_RCAN0>,
+			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	can1: can at e6e88000 {
+		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_RCAN1>,
+			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 222a9dcbabb8..9703fbdb81c8 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -96,6 +96,8 @@
 #define R8A7794_CLK_GPIO2		10
 #define R8A7794_CLK_GPIO1		11
 #define R8A7794_CLK_GPIO0		12
+#define R8A7794_CLK_RCAN1		15
+#define R8A7794_CLK_RCAN0		16
 #define R8A7794_CLK_QSPI_MOD		17
 #define R8A7794_CLK_I2C5		25
 #define R8A7794_CLK_I2C4		27
-- 
2.1.4
