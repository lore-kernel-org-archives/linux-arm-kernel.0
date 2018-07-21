From: simon@lineageos.org (Simon Shields)
Date: Sat, 21 Jul 2018 22:50:53 +1000
Subject: [PATCH 5/5] ARM: dts: exynos: configure midas SD card CD pin
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Message-ID: <20180721125128.31498-6-simon@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pin is externally pulled up, so we need to disable the SoC's
internal pull down resistor to allow it to function properly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index d69bc3c2d0ff..3d3e6b74c12e 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -1152,6 +1152,11 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	sdhci2_cd: sdhci2-cd-irq {
+		samsung,pins = "gpx3-4";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -1383,7 +1388,7 @@
 	bus-width = <4>;
 	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo21_reg>;
 	status = "okay";
-- 
2.18.0
