From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 22 Feb 2017 16:55:03 +0800
Subject: [PATCH v3 6/8] arm64: dts: mt8173: split usb SuperSpeed port into two
 ports
In-Reply-To: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1487753705-6745-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

split the old SuperSpeed port node into a HighSpeed one and a new
SuperSpeed one.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 12e7027..12c90e5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -724,8 +724,9 @@
 			      <0 0x11280700 0 0x0100>;
 			reg-names = "mac", "ippc";
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>;
-			phys = <&phy_port0 PHY_TYPE_USB3>,
-			       <&phy_port1 PHY_TYPE_USB2>;
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>,
+			       <&u2port1 PHY_TYPE_USB2>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
 			clocks = <&topckgen CLK_TOP_USB30_SEL>,
 				 <&pericfg CLK_PERI_USB0>,
@@ -761,14 +762,20 @@
 			ranges;
 			status = "okay";
 
-			phy_port0: port at 11290800 {
-				reg = <0 0x11290800 0 0x800>;
+			u2port0: usb-phy at 11290800 {
+				reg = <0 0x11290800 0 0x100>;
 				#phy-cells = <1>;
 				status = "okay";
 			};
 
-			phy_port1: port at 11291000 {
-				reg = <0 0x11291000 0 0x800>;
+			u3port0: usb-phy at 11290900 {
+				reg = <0 0x11290900 0 0x700>;
+				#phy-cells = <1>;
+				status = "okay";
+			};
+
+			u2port1: usb-phy at 11291000 {
+				reg = <0 0x11291000 0 0x100>;
 				#phy-cells = <1>;
 				status = "okay";
 			};
-- 
1.7.9.5
