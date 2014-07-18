From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 18 Jul 2014 19:20:07 +0200
Subject: [PATCH v2 2/4] ARM: dts: exynos5250: cypress,
 cyapa trackpad is Snow only
In-Reply-To: <1405704009-8430-1-git-send-email-afaerber@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
Message-ID: <1405704009-8430-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
Spring does not need it, it uses an Atmel maXTouch instead.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New (Doug Anderson)

 arch/arm/boot/dts/exynos5250-cros-common.dtsi |  8 --------
 arch/arm/boot/dts/exynos5250-snow.dts         | 10 ++++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 61128d1..e603e9c 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -39,14 +39,6 @@
 		status = "okay";
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
-
-		trackpad {
-			reg = <0x67>;
-			compatible = "cypress,cyapa";
-			interrupts = <2 0>;
-			interrupt-parent = <&gpx1>;
-			wakeup-source;
-		};
 	};
 
 	i2c at 12C80000 {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 0f867a3..f2b8c41 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -490,6 +490,16 @@
 	};
 };
 
+&i2c_1 {
+	trackpad {
+		reg = <0x67>;
+		compatible = "cypress,cyapa";
+		interrupts = <2 0>;
+		interrupt-parent = <&gpx1>;
+		wakeup-source;
+	};
+};
+
 &pinctrl_0 {
 	max77686_irq: max77686-irq {
 		samsung,pins = "gpx3-2";
-- 
1.9.3
