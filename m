From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:06 +0200
Subject: [PATCH 11/29] arm64: dts: renesas: r8a7795: add ccree to device tree
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <0f6d237cafda2e06b289eab1fa2addf09e666a07.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gilad Ben-Yossef <gilad@benyossef.com>

Add bindings for CryptoCell instance in the SoC.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d842940b2f43..3ac75dbf2d93 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -528,6 +528,15 @@
 			status = "disabled";
 		};
 
+		arm_cc630p: crypto at e6601000 {
+			compatible = "arm,cryptocell-630p-ree";
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0xe6601000 0 0x1000>;
+			clocks = <&cpg CPG_MOD 229>;
+			resets = <&cpg 229>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		};
+
 		i2c3: i2c at e66d0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.11.0
