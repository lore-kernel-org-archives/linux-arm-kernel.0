From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:27 +0100
Subject: [RESEND 05/10] ARM: STi: STiH407: Add PWM Regulator node
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 64a1a26..3c1bd5d 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -65,6 +65,17 @@
 		interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pwm_regulator: pwm-regulator {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 3 8448>;
+		regulator-name = "CPU_1V0_AVS";
+		regulator-min-microvolt = <784000>;
+		regulator-max-microvolt = <1299000>;
+		regulator-always-on;
+		max-duty-cycle = <255>;
+		status = "okay";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
