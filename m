From: dawei.chien@mediatek.com (Dawei Chien)
Date: Fri, 5 Feb 2016 13:47:38 +0800
Subject: [PATCH] arm64: dts: mt8173: add node for thermal calibration
Message-ID: <1454651258-41990-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add this for supporting thermal calibration by e-fuse data.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
Because MTK thermal/efuse patches hadn't landed on mainline, this patch
must base on following patchset:
https://lkml.org/lkml/2015/11/17/251
https://lkml.org/lkml/2015/11/19/169
https://lkml.org/lkml/2015/11/30/239
https://lkml.org/lkml/2015/12/16/195
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index ffcca66..0c9d17e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -391,6 +391,11 @@
 		efuse: efuse at 10206000 {
 			compatible = "mediatek,mt8173-efuse";
 			reg = <0 0x10206000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			thermal_calibration: calib at 528 {
+				reg = <0x528 0xc>;
+			};
 		};
 
 		apmixedsys: clock-controller at 10209000 {
@@ -744,6 +749,8 @@
 			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
 			mediatek,auxadc = <&auxadc>;
 			mediatek,apmixedsys = <&apmixedsys>;
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
 		};
 	};
 };
-- 
1.7.9.5
