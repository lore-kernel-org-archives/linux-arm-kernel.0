From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:57:49 +0100
Subject: [REBASED 1/5] ARM: STi: STiH407: Add PWM Regulator node
In-Reply-To: <1433923073-907-1-git-send-email-lee.jones@linaro.org>
References: <1433923073-907-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1433923073-907-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index e096105..be201aa 100644
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
