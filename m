From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Dec 2016 17:24:04 +0100
Subject: [PATCH v2 2/2] arm64: dts: r8a7796: salvator-x: Enable EthernetAVB
In-Reply-To: <1481819044-19605-1-git-send-email-geert+renesas@glider.be>
References: <1481819044-19605-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1481819044-19605-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[geert: Add pinctrl]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add pinctrl.
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 38bde9de3250ecbb..c7f40f8f3169f36b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -18,6 +18,7 @@
 
 	aliases {
 		serial0 = &scif2;
+		ethernet0 = &avb;
 	};
 
 	chosen {
@@ -107,6 +108,11 @@
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	avb_pins: avb {
+		groups = "avb_mdc";
+		function = "avb";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
@@ -158,6 +164,32 @@
 	};
 };
 
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <900>;
+		rxdv-skew-ps = <0>;
+		rxd0-skew-ps = <0>;
+		rxd1-skew-ps = <0>;
+		rxd2-skew-ps = <0>;
+		rxd3-skew-ps = <0>;
+		txc-skew-ps = <900>;
+		txen-skew-ps = <0>;
+		txd0-skew-ps = <0>;
+		txd1-skew-ps = <0>;
+		txd2-skew-ps = <0>;
+		txd3-skew-ps = <0>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
-- 
1.9.1
