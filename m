From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 21 Sep 2017 19:14:45 +0200
Subject: [PATCH 2/7] ARM64: dts: meson-gx: remove gpio offset
In-Reply-To: <20170921171450.27407-1-jbrunet@baylibre.com>
References: <20170921171450.27407-1-jbrunet@baylibre.com>
Message-ID: <20170921171450.27407-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove pin offset on the EE controller. Meson pinctrl no longer has
this quirk

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 52f1687e7a09..fb4baed97a01 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -379,7 +379,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_periphs 0 14 120>;
+			gpio-ranges = <&pinctrl_periphs 0 0 120>;
 		};
 
 		emmc_pins: emmc {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d6876e64979e..f3fca26c9658 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -268,7 +268,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_periphs 0 10 101>;
+			gpio-ranges = <&pinctrl_periphs 0 0 101>;
 		};
 
 		emmc_pins: emmc {
-- 
2.13.5
