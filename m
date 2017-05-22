From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:36 +0200
Subject: [PATCH 03/35] arm64: dts: m3ulcb: enable EthernetAVB
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <883fae315a6af7d2b7dd32e79471c787d9b29baf.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

This supports Ethernet AVB on M3ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 02051a3236a5..75974b246dd1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -20,6 +20,7 @@
 
 	aliases {
 		serial0 = &scif2;
+		ethernet0 = &avb;
 	};
 
 	chosen {
@@ -115,6 +116,11 @@
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
@@ -155,6 +161,32 @@
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
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-1 = <&sdhi0_pins_uhs>;
-- 
2.1.4
