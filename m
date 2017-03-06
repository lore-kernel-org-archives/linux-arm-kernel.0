From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 6 Mar 2017 21:49:28 +0800
Subject: [RESEND PATCH v3 7/8] arm64: dts: mt8173: move clock from phy node
 into port nodes
In-Reply-To: <1488808169-6031-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1488808169-6031-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1488808169-6031-7-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there is a reference clock for each port, HighSpeed port is 48M,
and SuperSpeed port is 26M which usually comes from 26M oscillator
directly, but some SoCs is not. it is flexible to move it into port
node.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 1dc4629..1c9e0d5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -764,8 +764,6 @@
 		u3phy: usb-phy at 11290000 {
 			compatible = "mediatek,mt8173-u3phy";
 			reg = <0 0x11290000 0 0x800>;
-			clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
-			clock-names = "u3phya_ref";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -773,18 +771,24 @@
 
 			u2port0: usb-phy at 11290800 {
 				reg = <0 0x11290800 0 0x100>;
+				clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+				clock-names = "ref";
 				#phy-cells = <1>;
 				status = "okay";
 			};
 
 			u3port0: usb-phy at 11290900 {
 				reg = <0 0x11290900 0 0x700>;
+				clocks = <&clk26m>;
+				clock-names = "ref";
 				#phy-cells = <1>;
 				status = "okay";
 			};
 
 			u2port1: usb-phy at 11291000 {
 				reg = <0 0x11291000 0 0x100>;
+				clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+				clock-names = "ref";
 				#phy-cells = <1>;
 				status = "okay";
 			};
-- 
1.7.9.5
