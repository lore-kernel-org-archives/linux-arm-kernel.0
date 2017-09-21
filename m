From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 21 Sep 2017 19:14:46 +0200
Subject: [PATCH 3/7] ARM64: dts: meson-gx: adjust gpio-ranges for TEST_N
In-Reply-To: <20170921171450.27407-1-jbrunet@baylibre.com>
References: <20170921171450.27407-1-jbrunet@baylibre.com>
Message-ID: <20170921171450.27407-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TEST_N has moved from the EE controller to the AO controller so
the gpio-ranges need to adjusted for it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index fb4baed97a01..e5a7bdead275 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -379,7 +379,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_periphs 0 0 120>;
+			gpio-ranges = <&pinctrl_periphs 0 0 119>;
 		};
 
 		emmc_pins: emmc {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index f3fca26c9658..084cef1842e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -268,7 +268,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_periphs 0 0 101>;
+			gpio-ranges = <&pinctrl_periphs 0 0 100>;
 		};
 
 		emmc_pins: emmc {
-- 
2.13.5
