From: ayaka@soulik.info (Randy Li)
Date: Sun, 28 Aug 2016 19:21:08 +0800
Subject: [PATCH 3/4] ARM: dts: add fimc support in exynos4412 TOPEET iTop
 Elite board
In-Reply-To: <1472383269-3126-1-git-send-email-ayaka@soulik.info>
References: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
 <1472383269-3126-1-git-send-email-ayaka@soulik.info>
Message-ID: <1472383269-3126-4-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The is not used for camera, I enabled it just for a colorspace
convertor.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/exynos4412-itop-elite.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 5688589..2d11b9a 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -82,6 +82,14 @@
 		pinctrl-0 = <&pwm0_out>;
 		pinctrl-names = "default";
 	};
+
+	camera: camera {
+		pinctrl-0 = <&cam_port_a_clk_active>;
+		pinctrl-names = "default";
+		status = "okay";
+		assigned-clocks = <&clock CLK_MOUT_CAM0>;
+		assigned-clock-parents = <&clock CLK_XUSBXTI>;
+	};
 };
 
 &pinctrl_1 {
@@ -146,3 +154,11 @@
 	vdd-supply = <&ldo3_reg>;
 	status = "okay";
 };
+
+&fimc_0 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+			<&clock CLK_SCLK_FIMC0>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
-- 
2.7.4
