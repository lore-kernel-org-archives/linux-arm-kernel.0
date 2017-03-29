From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Wed, 29 Mar 2017 15:25:23 +0200
Subject: [PATCH v1 5/8] ARM: dts: stm32: Enable stmpe1600 gpio expandor of
 STM32F429-EVAL board
In-Reply-To: <1490793926-6477-1-git-send-email-hugues.fruchet@st.com>
References: <1490793926-6477-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1490793926-6477-6-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 87733d3..7ffcf07 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -154,6 +154,23 @@
 	pinctrl-0 = <&i2c1_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	stmpe1600: stmpe1600 at 42 {
+		compatible = "st,stmpe1600";
+		reg = <0x42>;
+		irq-gpio = <&gpioi 8 0>;
+		irq-trigger = <3>;
+		interrupts = <8 3>;
+		interrupt-parent = <&exti>;
+		interrupt-controller;
+		wakeup-source;
+
+		stmpegpio: stmpe_gpio {
+			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
 };
 
 &mac {
-- 
1.9.1
