From: linux.amoon@gmail.com (Anand Moon)
Date: Fri,  6 Oct 2017 04:36:34 +0000
Subject: [RFC 1/2] ARM: dts: exynos: update the usbdrd phy and ref clk
Message-ID: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update the usbdrd link control and phy contol clks.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid XU4 and Odroid HC1 develpment board.
Did not test Odroid XU develpment board.
---
 arch/arm/boot/dts/exynos5410.dtsi | 4 ++--
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 7eab4bc..5af9f4b 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -385,7 +385,7 @@
 };
 
 &usbdrd_phy0 {
-	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
+	clocks = <&clock CLK_SCLK_USBPHY300>, <&clock CLK_SCLK_USBD300>;
 	clock-names = "phy", "ref";
 	samsung,pmu-syscon = <&pmu_system_controller>;
 };
@@ -400,7 +400,7 @@
 };
 
 &usbdrd_phy1 {
-	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
+	clocks = <&clock CLK_SCLK_USBPHY301>, <&clock CLK_SCLK_USBD301>;
 	clock-names = "phy", "ref";
 	samsung,pmu-syscon = <&pmu_system_controller>;
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 88e5d6d..36d26ab 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1461,7 +1461,7 @@
 };
 
 &usbdrd_phy0 {
-	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
+	clocks = <&clock CLK_SCLK_USBPHY300>, <&clock CLK_SCLK_USBD300>;
 	clock-names = "phy", "ref";
 	samsung,pmu-syscon = <&pmu_system_controller>;
 };
@@ -1476,7 +1476,7 @@
 };
 
 &usbdrd_phy1 {
-	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
+	clocks = <&clock CLK_SCLK_USBPHY301>, <&clock CLK_SCLK_USBD301>;
 	clock-names = "phy", "ref";
 	samsung,pmu-syscon = <&pmu_system_controller>;
 };
-- 
2.7.4
