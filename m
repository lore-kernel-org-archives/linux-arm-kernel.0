From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Jan 2017 15:20:51 +0100
Subject: [PATCH v8 8/8] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-disco
In-Reply-To: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1484749251-14445-9-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define and enable pwm1 and pwm3 for stm32f469 discovery board

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..92552d3 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -81,3 +81,31 @@
 &usart3 {
 	status = "okay";
 };
+
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
-- 
1.9.1
