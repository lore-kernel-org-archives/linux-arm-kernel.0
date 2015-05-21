From: yh.huang@mediatek.com (YH Huang)
Date: Thu, 21 May 2015 21:29:23 +0800
Subject: [PATCH v2 1/2] dt-bindings: pwm: add MediaTek display PWM bindings
In-Reply-To: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1432214964-40644-2-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device-tree binding of MediatTek display PWM.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
new file mode 100644
index 0000000..f55bf92
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -0,0 +1,25 @@
+MediaTek display PWM controller
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
