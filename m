From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 10:35:08 +0100
Subject: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Message-ID: <20160816093508.28307-18-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
be more inline with the naming conventions of the subsystem.  Where
we used to treat each line as a channel, the PWM convention is to
describe them as devices.

The second documentation adaption entails adding support for PWM
capture devices.  A new clock is required as well as an IRQ line.
We're also adding a new property similar to the one described
above, but for capture channels.  Typically, there will be less
capture channels than PWM-out, since all channels have the latter
capability, but only some have capture support.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/pwm/pwm-st.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
index 84d2fb8..19fce77 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
@@ -13,13 +13,14 @@ Required parameters:
 - pinctrl-0: 		List of phandles pointing to pin configuration nodes
 			for PWM module.
 			For Pinctrl properties, please refer to [1].
-- clock-names: 		Set to "pwm".
+- clock-names: 		Valid entries are "pwm" and/or "capture".
 - clocks: 		phandle of the clock used by the PWM module.
 			For Clk properties, please refer to [2].
+- interrupts:		IRQ for the Capture device
 
 Optional properties:
-- st,pwm-num-chan:	Number of available channels. If not passed, the driver
-			will consider single channel by default.
+- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
+- st,capture-num-chan:	Number of available Capture channels.  Default is 0.
 
 [1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -38,4 +39,5 @@ pwm1: pwm at fe510000 {
 	clocks = <&clk_sysin>;
 	clock-names = "pwm";
 	st,pwm-num-chan = <4>;
+	st,capture-num-chan = <2>;
 };
-- 
2.9.0
