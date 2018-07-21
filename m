From: simon@lineageos.org (Simon Shields)
Date: Sat, 21 Jul 2018 22:50:49 +1000
Subject: [PATCH 1/5] ARM: dts: exynos: add max77693 pinctrl config for midas
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Message-ID: <20180721125128.31498-2-simon@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we assume that the bootloader has correctly configured
the interrupt pin for max77693. This might not actually be the case -
so it's better to configure it explicitly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index f12372509061..ee7cda1432f7 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -156,6 +156,8 @@
 			compatible = "maxim,max77693";
 			interrupt-parent = <&gpx1>;
 			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_irq>;
 			reg = <0x66>;
 
 			regulators {
@@ -1124,6 +1126,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep1>;
 
+	max77693_irq: max77693-irq {
+		samsung,pins = "gpx1-5";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
-- 
2.18.0
