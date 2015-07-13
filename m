From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 13 Jul 2015 17:04:52 +0800
Subject: [PATCH v5 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
In-Reply-To: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
References: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1436778294-47635-2-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device-tree binding of MediatTek display PWM.
The PWM has one channel to control the backlight brightness for display.
It supports MT8173 and MT6595.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
new file mode 100644
index 0000000..aac29dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -0,0 +1,29 @@
+MediaTek display PWM controller
+
+Required properties:
+ - compatible: should be "mediatek,<name>-disp-pwm":
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+ - reg: physical base address and length of the controller's registers.
+ - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
+   the cell format.
+ - clocks: phandle and clock specifier of the PWM reference clock.
+ - clock-names: must contain the following:
+   - "main": clock used to generate PWM signals.
+   - "mm": sync signals from the modules of mmsys.
+ - pinctrl-names: Must contain a "default" entry.
+ - pinctrl-0: One property must exist for each entry in pinctrl-names.
+   See pinctrl/pinctrl-bindings.txt for details of the property values.
+
+Example:
+	pwm0: pwm at 1401e000 {
+		compatible = "mediatek,mt8173-disp-pwm",
+			     "mediatek,mt6595-disp-pwm";
+		reg = <0 0x1401e000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+			 <&mmsys CLK_MM_DISP_PWM0MM>;
+		clock-names = "main", "mm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&disp_pwm0_pins>;
+	};
-- 
1.8.1.1.dirty
