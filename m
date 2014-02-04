From: tim.kryger@linaro.org (Tim Kryger)
Date: Tue, 4 Feb 2014 11:51:41 -0800
Subject: [PATCH v2 3/5] ARM: dts: Declare the PWM for bcm11351 (bcm281xx)
In-Reply-To: <1391543503-14773-1-git-send-email-tim.kryger@linaro.org>
References: <1391543503-14773-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1391543503-14773-4-git-send-email-tim.kryger@linaro.org>
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
index e491b82..5296c3d 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -191,6 +191,14 @@
 		status = "disabled";
 	};
 
+	pwm: pwm at 3e01a000 {
+		compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+		reg = <0x3e01a000 0xcc>;
+		clocks = <&pwm_clk>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	clocks {
 		bsc1_clk: bsc1 {
 			compatible = "fixed-clock";
-- 
1.8.0.1
