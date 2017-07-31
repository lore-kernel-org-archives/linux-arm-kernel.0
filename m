From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:14 +0200
Subject: [PATCH 22/31] arm64: dts: salvator-xs: Add VC6 clock generator
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <b127daecc70896fce7a2b2ada2f43b9ba7868b92.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The VC6 is an I2C-controlled programmable clock generator, used on the
board to provide a display dot clock. Add it to DT.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-xs.dtsi b/arch/arm64/boot/dts/renesas/salvator-xs.dtsi
index 81227e3c2c6f..bf4d200fb546 100644
--- a/arch/arm64/boot/dts/renesas/salvator-xs.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-xs.dtsi
@@ -18,3 +18,13 @@
 &extal_clk {
 	clock-frequency = <16640000>;
 };
+
+&i2c4 {
+	versaclock6: clock-generator at 6a {
+		compatible = "idt,5p49v6901";
+		reg = <0x6a>;
+		#clock-cells = <1>;
+		clocks = <&x23_clk>;
+		clock-names = "xin";
+	};
+};
-- 
2.1.4
