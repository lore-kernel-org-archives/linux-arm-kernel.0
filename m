From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 3 Jan 2018 16:53:22 +0800
Subject: [v2 PATCH 6/6] arm64: dts: mt8173: update properties about USB wakeup
In-Reply-To: <41c6b0f2e959c07eff261060e57fd180a750071a.1514967463.git.chunfeng.yun@mediatek.com>
References: <41c6b0f2e959c07eff261060e57fd180a750071a.1514967463.git.chunfeng.yun@mediatek.com>
Message-ID: <10e220e2456f620442cd52c25fcda009dbbb653c.1514967463.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new binding about USB wakeup which now supports multi USB
wakeup glue layer between SSUSB and SPM.
Meanwhile remove dummy clocks of USB wakeup.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 1c3634f..0acba1f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -505,7 +505,7 @@
 	vbus-supply = <&usb_p0_vbus>;
 	extcon = <&extcon_usb>;
 	dr_mode = "otg";
-	mediatek,enable-wakeup;
+	wakeup-source;
 	pinctrl-names = "default", "id_float", "id_ground";
 	pinctrl-0 = <&usb_id_pins_float>;
 	pinctrl-1 = <&usb_id_pins_float>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 26396ef..9263d9f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -731,15 +731,9 @@
 			       <&u3port0 PHY_TYPE_USB3>,
 			       <&u2port1 PHY_TYPE_USB2>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-			clocks = <&topckgen CLK_TOP_USB30_SEL>,
-				 <&clk26m>,
-				 <&pericfg CLK_PERI_USB0>,
-				 <&pericfg CLK_PERI_USB1>;
-			clock-names = "sys_ck",
-				      "ref_ck",
-				      "wakeup_deb_p0",
-				      "wakeup_deb_p1";
-			mediatek,syscon-wakeup = <&pericfg>;
+			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+			clock-names = "sys_ck", "ref_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
1.9.1
