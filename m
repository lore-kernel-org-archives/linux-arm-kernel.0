From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Nov 2015 13:31:45 +0900
Subject: [PATCH v6 2/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
In-Reply-To: <1446438708-22433-1-git-send-email-horms+renesas@verge.net.au>
References: <1446438708-22433-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1446438708-22433-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v0 [Kazuya Mizuguchi]

v1 [Simon Horman]
* updated filename to salvator-x
* updated patch subject

v2 [Simon Horman]
* Removed spurious update to r8a7795.dtsi introduced in v1
* Removed unused renesas,phy property

v3 [Simon Horman]
* No change but provided PFC driver update in separate patch(set)

v4 [Simon Horman]
* As suggested by Sergei Shtylyov
  - Removed unused phy-reset-gpio property

v5, v6
* No change
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index f522fda7843a..4fb120d8e7e8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -45,6 +45,11 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+
+	avb_pins: avb {
+		renesas,groups = "avb_mdc";
+		renesas,function = "avb";
+	};
 };
 
 &scif1 {
@@ -60,3 +65,29 @@
 
 	status = "okay";
 };
+
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
-- 
2.1.4
