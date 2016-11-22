From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 22 Nov 2016 17:13:25 +0100
Subject: [PATCH 5/7] add bindings for stm32 IIO timer drivers
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define bindings for stm32 IIO timer

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/iio/timer/stm32-iio-timer.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
new file mode 100644
index 0000000..b80025e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
@@ -0,0 +1,33 @@
+timer IIO trigger bindings for STM32
+
+Must be a child of STM32 multifunctions timer driver
+
+Required parameters:
+- compatible: must be one of the follow value:
+	"st,stm32-iio-timer1"
+	"st,stm32-iio-timer2"
+	"st,stm32-iio-timer3"
+	"st,stm32-iio-timer4"
+	"st,stm32-iio-timer5"
+	"st,stm32-iio-timer6"
+	"st,stm32-iio-timer7"
+	"st,stm32-iio-timer8"
+	"st,stm32-iio-timer9"
+	"st,stm32-iio-timer10"
+	"st,stm32-iio-timer11"
+	"st,stm32-iio-timer12"
+	"st,stm32-iio-timer13"
+	"st,stm32-iio-timer14"
+
+Example:
+	mfd_timer1: mfdtimer1 at 40010000 {
+		compatible = "st,stm32-mfd-timer1";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "mfd_timer_clk";
+		interrupts = <27>;
+
+		trigger1: trigger1 at 40010000 {
+			compatible = "st,stm32-iio-timer1";
+		};
+	};
-- 
1.9.1
