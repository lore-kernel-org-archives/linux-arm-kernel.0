From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 22 Nov 2016 17:13:21 +0100
Subject: [PATCH 1/7] add binding for stm32 multifunctions timer driver
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings information for stm32 timer MFD

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/mfd/stm32-timer.txt        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
new file mode 100644
index 0000000..3cefce1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
@@ -0,0 +1,53 @@
+STM32 multifunctions timer driver
+
+stm32 timer MFD allow to handle at the same time pwm and IIO timer devices
+
+Required parameters:
+- compatible: must be one of the follow value:
+	"st,stm32-mfd-timer1"
+	"st,stm32-mfd-timer2"
+	"st,stm32-mfd-timer3"
+	"st,stm32-mfd-timer4"
+	"st,stm32-mfd-timer5"
+	"st,stm32-mfd-timer6"
+	"st,stm32-mfd-timer7"
+	"st,stm32-mfd-timer8"
+	"st,stm32-mfd-timer9"
+	"st,stm32-mfd-timer10"
+	"st,stm32-mfd-timer11"
+	"st,stm32-mfd-timer12"
+	"st,stm32-mfd-timer13"
+	"st,stm32-mfd-timer14"
+
+- reg :			Physical base address and length of the controller's
+			registers.
+- clock-names: 		Set to "mfd_timer_clk".
+- clocks: 		Phandle of the clock used by the timer module.
+			For Clk properties, please refer to [1].
+- interrupts :		Reference to the timer interrupt
+
+Optional parameters:
+- resets :		Reference to a reset controller asserting the timer
+
+Optional subnodes:
+- pwm:			See Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+- iiotimer:		See Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Example:
+	mfd_timer1: mfdtimer1 at 40010000 {
+		compatible = "st,stm32-mfd-timer1";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "mfd_timer_clk";
+		interrupts = <27>;
+
+		pwm1: pwm1 at 40010000 {
+			compatible = "st,stm32-pwm1";
+		};
+
+		iiotimer1: iiotimer1 at 40010000 {
+			compatible = "st,stm32-iio-timer1";
+		};
+	};
-- 
1.9.1
