From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  2 Jan 2015 16:24:14 +0100
Subject: [PATCH RESEND 1/4] ARM: dts: Add power and lid GPIO keys pinctrl for
 exynos5250-snow
In-Reply-To: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1420212257-22443-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5250 Snow Chromebook has GPIO keys for power and lid
so the SoC I/O pins have to be configured in external interrupt
mode. Currently, this is working without setting the pinctrl
lines but is better to set it explicitly instead of relying on
the previous state of the I/O pins.

The DTS snippets were taken from the downstream ChromeOS tree.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index effaf2a..b9aeec4 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -33,6 +33,8 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&power_key_irq &lid_irq>;
 
 		power {
 			label = "Power";
@@ -540,6 +542,13 @@
 };
 
 &pinctrl_0 {
+	power_key_irq: power-key-irq {
+		samsung,pins = "gpx1-3";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	ec_irq: ec-irq {
 		samsung,pins = "gpx1-6";
 		samsung,pin-function = <0>;
@@ -575,6 +584,13 @@
 		samsung,pin-drv = <0>;
 	};
 
+	lid_irq: lid-irq {
+		samsung,pins = "gpx3-5";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <0>;
-- 
2.1.3
