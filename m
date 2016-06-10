From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Jun 2016 15:23:30 +0200
Subject: [PATCH 02/10] arm64: dts: marvell: Add xtal clock support for Armada
 3700
In-Reply-To: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465565018-14172-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The configuration of the clock depend of the gpio latch. This information
is stored in the gpio block registers. That's why the block is shared
using a syscon node.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 9e2efb882983..7c61e13a16f3 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -105,6 +105,18 @@
 				status = "disabled";
 			};
 
+			gpio1: gpio at 13800 {
+				compatible = "marvell,mvebu-gpio-3700",
+				"syscon", "simple-mfd";
+				reg = <0x13800 0x500>;
+
+				xtalclk: xtal-clk {
+					compatible = "marvell,armada-3700-xtal-clock";
+					clock-output-names = "xtal";
+					#clock-cells = <0>;
+				};
+			};
+
 			usb3: usb at 58000 {
 				compatible = "marvell,armada3700-xhci",
 				"generic-xhci";
-- 
2.5.0
