From: tim.kryger@linaro.org (Tim Kryger)
Date: Wed, 12 Mar 2014 13:15:44 -0700
Subject: [PATCH v3 3/5] ARM: dts: Declare the PWM for bcm11351 (bcm281xx)
In-Reply-To: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1394655346-30048-4-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree node for the PWM on bcm11351 SoCs.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 64d069b..6b05ae6 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -193,6 +193,14 @@
 		status = "disabled";
 	};
 
+	pwm: pwm at 3e01a000 {
+		compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+		reg = <0x3e01a000 0xcc>;
+		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.0.1
