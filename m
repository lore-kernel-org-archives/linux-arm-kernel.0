From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:44 +0200
Subject: [PATCH 11/69] ARM: dts: renesas: r8a7793: Add FDP1 instances
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <d7ce14dfbaff685a65b56bdb6622b430ae9ad57a.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7793 has two FDP1 instances.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index f9c5a557107d..61c58029e03e 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1290,6 +1290,24 @@
 			resets = <&cpg 408>;
 		};
 
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+			resets = <&cpg 119>;
+		};
+
+		fdp1 at fe944000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
+			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+			resets = <&cpg 118>;
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7793";
 			reg = <0 0xfeb00000 0 0x40000>,
-- 
2.11.0
