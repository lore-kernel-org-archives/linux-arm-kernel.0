From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 22 Sep 2015 15:43:19 +0800
Subject: [PATCH v5 07/17] ARM: dts: exynos/dp: remove some properties that
 deprecated by analogix_dp driver
In-Reply-To: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
References: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1442907799-6266-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After exynos_dp have been split the common IP code into analogix_dp driver,
the analogix_dp driver have deprecated some Samsung platform properties which
could be dynamically parsed from EDID/MODE/DPCD message, so this is an update
for Exynos DTS file for dp-controller.

Beside the backward compatibility is fully preserved, so there are no
bisectability break that make this change in a separate patch.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v5:
- Correct the misspell in commit message. (Krzysztof)

Changes in v4:
- Separate all DTS changes to a separate patch. (Krzysztof)

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/exynos5250-arndale.dts   | 2 --
 arch/arm/boot/dts/exynos5250-smdk5250.dts  | 2 --
 arch/arm/boot/dts/exynos5250-snow.dts      | 4 +---
 arch/arm/boot/dts/exynos5250-spring.dts    | 4 +---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 +---
 arch/arm/boot/dts/exynos5420-smdk5420.dts  | 2 --
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 +---
 7 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index db3f65f..4636862 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -124,8 +124,6 @@
 &dp {
 	status = "okay";
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <4>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index c625e71..cd424d6 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -80,8 +80,6 @@
 
 &dp {
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <4>;
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 0720caa..242b621 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -244,12 +244,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hpd>;
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <2>;
-	samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpx0 7 GPIO_ACTIVE_HIGH>;
 
 	ports {
 		port at 0 {
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index c1edd6d..91881d7 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -74,12 +74,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hpd_gpio>;
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <1>;
-	samsung,hpd-gpio = <&gpc3 0 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpc3 0 GPIO_ACTIVE_HIGH>;
 };
 
 &ehci {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 8f4d76c..7433683 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -148,12 +148,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hpd_gpio>;
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x06>;
 	samsung,lane-count = <2>;
-	samsung,hpd-gpio = <&gpx2 6 0>;
+	hpd-gpio = <&gpx2 6 0>;
 
 	ports {
 		port at 0 {
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 98871f9..b3df3c1 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -92,8 +92,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hpd>;
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <4>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7d5b386..b89bff5 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -142,12 +142,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hpd_gpio>;
 	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
 	samsung,color-depth = <1>;
 	samsung,link-rate = <0x0a>;
 	samsung,lane-count = <2>;
-	samsung,hpd-gpio = <&gpx2 6 0>;
+	hpd-gpios = <&gpx2 6 0>;
 	panel = <&panel>;
 };
 
-- 
1.9.1
