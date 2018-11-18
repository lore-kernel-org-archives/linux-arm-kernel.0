From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 18 Nov 2018 18:33:27 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77965: Add CAN FD controller node
In-Reply-To: <20181118173327.4704-1-marek.vasut+renesas@gmail.com>
References: <20181118173327.4704-1-marek.vasut+renesas@gmail.com>
Message-ID: <20181118173327.4704-2-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds CAN FD controller nodes for the R8A77965 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 3485624921bf..1c86e6f4dc71 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -938,6 +938,31 @@
 			status = "disabled";
 		};
 
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a77965-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A77965_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77965_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+		};
+
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 8>;
-- 
2.18.0
