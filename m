From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 26 Jan 2017 15:28:35 +0100
Subject: [PATCH v2 7/7] ARM: dts: stm32: Enable pwm1 and pwm3 on
 stm32f429i-eval
In-Reply-To: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485440915-30119-8-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define and enable pwm1 and pwm3, timers1 & 3 trigger outputs on
on stm32f429i-eval board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Fix typo
- Sort phandles
---
 arch/arm/boot/dts/stm32429i-eval.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 2181220..507ee9d 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -157,6 +157,34 @@
 	};
 };
 
+&timers1 {
+	status = "okay";
+
+	pwm {
+		pinctrl-0 = <&pwm1_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer at 0 {
+		status = "okay";
+	};
+};
+
+&timers3 {
+	status = "okay";
+
+	pwm {
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer at 2 {
+		status = "okay";
+	};
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
