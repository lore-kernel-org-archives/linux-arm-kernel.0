From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  8 Apr 2017 02:34:35 +0800
Subject: [PATCH v2 05/11] arm64: allwinner: a64: add AXP803 node to Pine64
 device tree
In-Reply-To: <20170407183441.58750-1-icenowy@aosc.io>
References: <20170407183441.58750-1-icenowy@aosc.io>
Message-ID: <20170407183441.58750-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 (including Pine64+) boards have an AXP803 as its main PMIC.

Add its device node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c680ed385da3..2132d8e6cb3d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -95,6 +95,17 @@
 	status = "okay";
 };
 
+&r_rsb {
+	status = "okay";
+
+	axp803: pmic at 3a3 {
+		compatible = "x-powers,axp803";
+		reg = <0x3a3>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.12.2
