From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 11 May 2015 17:26:21 +0800
Subject: [PATCH 1/2] dt-bindings: pwm: add Mediatek display PWM bindings
In-Reply-To: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1431336382-13167-2-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device-tree binding of Mediatek display PWM.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-disp-mediatek.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt
new file mode 100644
index 0000000..ef54e9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt
@@ -0,0 +1,25 @@
+Mediatek display PWM controller
+
+Required properties:
+ - compatible: should be "mediatek,<name>-disp-pwm"
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
+   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
+ - reg: physical base address and length of the controller's registers
+ - #pwm-cells: must be 2. See pwm.txt in this directory
+   for a description of the cell format
+ - clocks: phandle and clock specifier of the PWM reference clock
+ - clock-names: must contain the following
+   - "main": clock used to generate PWM signals
+   - "mm": sync signals from the modules of mmsys
+
+Example:
+	pwm0: pwm at 1401e000 {
+		compatible = "mediatek,mt8173-disp-pwm",
+			     "mediatek,mt6595-disp-pwm";
+		reg = <0 0x1401e000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys MM_DISP_PWM026M>,
+			 <&mmsys MM_DISP_PWM0MM>;
+		clock-names = "main",
+			      "mm";
+	};
-- 
1.8.1.1.dirty
