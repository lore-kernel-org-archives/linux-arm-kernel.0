From: simon@lineageos.org (Simon Shields)
Date: Sat, 21 Jul 2018 22:50:50 +1000
Subject: [PATCH 2/5] ARM: dts: exynos: add pinctrl config for midas keys
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Message-ID: <20180721125128.31498-3-simon@lineageos.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pins are externally pulled up, and so we should explicitly
configure them to disable the SoC-internal pull-downs. Previously
we relied on the bootloader doing this in order to allow the buttons
to function properly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index ee7cda1432f7..6f7b564905ab 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -112,6 +112,8 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys>;
 
 		key-down {
 			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
@@ -1126,6 +1128,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep1>;
 
+	gpio_keys: gpio-keys {
+		samsung,pins = "gpx0-1", "gpx2-2", "gpx2-7", "gpx3-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	max77693_irq: max77693-irq {
 		samsung,pins = "gpx1-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.18.0
