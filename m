From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 21 Sep 2017 19:14:49 +0200
Subject: [PATCH 6/7] ARM64: dts: meson-gxl: adjust kvim gpio-line-names
In-Reply-To: <20170921171450.27407-1-jbrunet@baylibre.com>
References: <20170921171450.27407-1-jbrunet@baylibre.com>
Message-ID: <20170921171450.27407-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TEST_N gpio has been moved so the gpio-line-names of the kvim
must be adjusted accordingly

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index edc512ad0bac..71a6e1ce7ad5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -122,7 +122,9 @@
 			  "J9 Header Pin33",
 			  "IR In",
 			  "HDMI CEC",
-			  "SYS LED";
+			  "SYS LED",
+			  /* GPIO_TEST_N */
+			  "";
 };
 
 &pinctrl_periphs {
@@ -163,9 +165,7 @@
 			  "WIFI 32K", "Bluetooth Enable",
 			  "Bluetooth WAKE HOST",
 			  /* Bank GPIOCLK */
-			  "", "J9 Header Pin39",
-			  /* GPIO_TEST_N */
-			  "";
+			  "", "J9 Header Pin39";
 };
 
 &pwm_AO_ab {
-- 
2.13.5
