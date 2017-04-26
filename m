From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:58 +0800
Subject: [PATCH v2 14/30] arm: dts: mt7623: add pwm nodes to the mt7623.dtsi
 file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-15-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add PWM nodes to the mt7623.dtsi file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 56da5ba..cfafaea 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -243,6 +243,22 @@
 		status = "disabled";
 	};
 
+	pwm: pwm at 11006000 {
+		compatible = "mediatek,mt7623-pwm";
+		reg = <0 0x11006000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&topckgen CLK_TOP_PWM_SEL>,
+			 <&pericfg CLK_PERI_PWM>,
+			 <&pericfg CLK_PERI_PWM1>,
+			 <&pericfg CLK_PERI_PWM2>,
+			 <&pericfg CLK_PERI_PWM3>,
+			 <&pericfg CLK_PERI_PWM4>,
+			 <&pericfg CLK_PERI_PWM5>;
+		clock-names = "top", "main", "pwm1", "pwm2",
+			      "pwm3", "pwm4", "pwm5";
+		status = "disabled";
+	};
+
 	i2c0: i2c at 11007000 {
 		compatible = "mediatek,mt7623-i2c",
 			     "mediatek,mt6577-i2c";
-- 
1.9.1
