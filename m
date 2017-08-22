From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 22 Aug 2017 19:22:46 +0100
Subject: [PATCH] ARM: dtsi: iwg22m: Add RTC support
Message-ID: <1503426166-26773-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the bq32000 RTC to the iwg22m device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---

 This patch has some dependency:
 * [1/2] ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM - https://patchwork.kernel.org/patch/9901619/
 * [2/2] ARM: dts: iwg22d-sodimm: Add support for iWave G22D-SODIMM board - https://patchwork.kernel.org/patch/9901623/
 * ARM: dtsi: r8a7745: Add I2C DT support - https://patchwork.kernel.org/patch/9915525/
 * [1/2] ARM: dts: r8a7745: Add MMC interface support - https://patchwork.kernel.org/patch/9906803/
 * [2/2] ARM: dtsi: iwg22m: Add eMMC support - https://patchwork.kernel.org/patch/9906805/

 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index afb1148..e306e7c 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -37,6 +37,11 @@
 		groups = "mmc_data8", "mmc_ctrl";
 		function = "mmc";
 	};
+
+	i2c3_pins: i2c3 {
+		groups = "i2c3_b";
+		function = "i2c3";
+	};
 };
 
 &mmcif0 {
@@ -48,3 +53,16 @@
 	non-removable;
 	status = "okay";
 };
+
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc at 68 {
+		compatible = "ti,bq32000";
+		reg = <0x68>;
+	};
+};
-- 
2.7.4
