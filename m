From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Jan 2017 15:20:48 +0100
Subject: [PATCH v8 5/8] IIO: add bindings for STM32 timer trigger driver
In-Reply-To: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1484749251-14445-6-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define bindings for STM32 timer trigger

version 8:
- reword "reg" parameter description

version 4:
- remove triggers enumeration from DT
- add reg parameter

version 3:
- change file name
- add cross reference with mfd bindings

version 2:
- only keep one compatible
- add DT parameters to set lists of the triggers:
  one list describe the triggers created by the device
  another one give the triggers accepted by the device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
new file mode 100644
index 0000000..55a653d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -0,0 +1,23 @@
+STMicroelectronics STM32 Timers IIO timer bindings
+
+Must be a sub-node of an STM32 Timers device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required parameters:
+- compatible:	Must be "st,stm32-timer-trigger".
+- reg:		Identify trigger hardware block.
+
+Example:
+	timers at 40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		timer at 0 {
+			compatible = "st,stm32-timer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1
