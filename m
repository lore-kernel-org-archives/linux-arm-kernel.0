From: simon@lineageos.org (Simon Shields)
Date: Sat, 21 Jul 2018 22:50:51 +1000
Subject: [PATCH 3/5] ARM: dts: exynos: add pinctrl for midas fuelgauge irq pin
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Message-ID: <20180721125128.31498-4-simon@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pin is externally pulled up, so we should disable the SoC's
pull down resistor in order for the interrupt to function properly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 6f7b564905ab..6a6364a9debd 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -206,6 +206,8 @@
 			compatible = "maxim,max17047";
 			interrupt-parent = <&gpx2>;
 			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_fuel_irq>;
 			reg = <0x36>;
 
 			maxim,over-heat-temp = <700>;
@@ -1138,6 +1140,11 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	max77693_fuel_irq: max77693-fuel-irq {
+		samsung,pins = "gpx2-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
-- 
2.18.0
