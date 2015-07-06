From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 6 Jul 2015 21:29:28 +0800
Subject: [PATCH v4 3/3] arm64: dts: mt8173: add MT8173 display PWM driver
 support dtsi
In-Reply-To: <1436189368-1826-1-git-send-email-yh.huang@mediatek.com>
References: <1436189368-1826-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1436189368-1826-4-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add display PWM node in mt8173.dtsi.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 0696f8f..e4ffd9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -393,6 +393,28 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		pwm0: pwm at 1401e000 {
+			compatible = "mediatek,mt8173-disp-pwm",
+				     "mediatek,mt6595-disp-pwm";
+			reg = <0 0x1401e000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&mmsys MM_DISP_PWM026M>,
+				 <&mmsys MM_DISP_PWM0MM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		pwm1: pwm at 1401f000 {
+			compatible = "mediatek,mt8173-disp-pwm",
+				     "mediatek,mt6595-disp-pwm";
+			reg = <0 0x1401f000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&mmsys MM_DISP_PWM126M>,
+				 <&mmsys MM_DISP_PWM1MM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
