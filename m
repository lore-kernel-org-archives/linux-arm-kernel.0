From: simon@lineageos.org (Simon Shields)
Date: Sat, 21 Jul 2018 22:50:52 +1000
Subject: [PATCH 4/5] ARM: dts: exynos: configure max77686 IRQ pin on midas
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Message-ID: <20180721125128.31498-5-simon@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pin is externally pulled up, so we need to disable the
SoC's internal pull-down.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 6a6364a9debd..d69bc3c2d0ff 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -685,6 +685,8 @@
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 IRQ_TYPE_NONE>;
+		pinctrl-0 = <&max77686_irq>;
+		pinctrl-names = "default";
 		reg = <0x09>;
 		#clock-cells = <1>;
 
@@ -1135,6 +1137,11 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	max77686_irq: max77686-irq {
+		samsung,pins = "gpx0-7";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	max77693_irq: max77693-irq {
 		samsung,pins = "gpx1-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.18.0
