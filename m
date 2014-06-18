From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 16:29:32 +0100
Subject: [PATCH v2 7/7] pwm: st: Supply Device Tree binding documentation for
 ST's PWM IP
In-Reply-To: <1403103172-19856-7-git-send-email-lee.jones@linaro.org>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20140618152932.GG15956@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm: st: Supply Device Tree binding documentation for ST's PWM IP
    
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
new file mode 100644
index 0000000..84d2fb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
@@ -0,0 +1,41 @@
+STMicroelectronics PWM driver bindings
+--------------------------------------
+
+Required parameters:
+- compatible :		"st,pwm"
+- #pwm-cells : 		Number of cells used to specify a PWM. First cell
+			specifies the per-chip index of the PWM to use and the
+			second cell is the period in nanoseconds - fixed to 2
+			for STiH41x.
+- reg :			Physical base address and length of the controller's
+			registers.
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes
+			for PWM module.
+			For Pinctrl properties, please refer to [1].
+- clock-names: 		Set to "pwm".
+- clocks: 		phandle of the clock used by the PWM module.
+			For Clk properties, please refer to [2].
+
+Optional properties:
+- st,pwm-num-chan:	Number of available channels. If not passed, the driver
+			will consider single channel by default.
+
+[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Example:
+
+pwm1: pwm at fe510000 {
+	compatible = "st,pwm";
+	reg = <0xfe510000 0x68>;
+	#pwm-cells = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1_chan0_default
+		     &pinctrl_pwm1_chan1_default
+		     &pinctrl_pwm1_chan2_default
+		     &pinctrl_pwm1_chan3_default>;
+	clocks = <&clk_sysin>;
+	clock-names = "pwm";
+	st,pwm-num-chan = <4>;
+};
