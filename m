From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 21 Apr 2014 15:23:01 +0800
Subject: [PATCHv2 1/3] clocksource: ftm: Add FlexTimer Module (FTM) Timer
 devicetree Documentation
In-Reply-To: <1398064983-440-1-git-send-email-Li.Xiubo@freescale.com>
References: <1398064983-440-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1398064983-440-2-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FTM binding could be used on Vybrid and LS1+, add a binding
document for it.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Jingchang Lu <b35083@freescale.com>
---
 .../devicetree/bindings/timer/fsl,ftm-timer.txt    | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
new file mode 100644
index 0000000..aa8c402
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
@@ -0,0 +1,31 @@
+Freescale FlexTimer Module (FTM) Timer
+
+Required properties:
+
+- compatible : should be "fsl,ftm-timer"
+- reg : Specifies base physical address and size of the register sets for the
+  clock event device and clock source device.
+- interrupts : Should be the clock event device interrupt.
+- clocks : The clocks provided by the SoC to drive the timer, must contain an
+  entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  o "ftm-evt"
+  o "ftm-src"
+  o "ftm-evt-counter-en"
+  o "ftm-src-counter-en"
+- big-endian: One boolean property, the big endian mode will be in use if it is
+  present, or the little endian mode will be in use for all the device registers.
+
+Example:
+ftm: ftm at 400b8000 {
+	compatible = "fsl,ftm-timer";
+	reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+	interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "ftm-evt", "ftm-src",
+		"ftm-evt-counter-en", "ftm-src-counter-en";
+	clocks = <&clks VF610_CLK_FTM2>,
+		<&clks VF610_CLK_FTM3>,
+		<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
+		<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
+	big-endian;
+};
-- 
1.8.4
