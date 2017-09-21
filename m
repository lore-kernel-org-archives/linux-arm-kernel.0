From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 21 Sep 2017 19:14:47 +0200
Subject: [PATCH 4/7] ARM64: dts: meson-gxbb: adjust nanopi-k2 gpio-line-names
In-Reply-To: <20170921171450.27407-1-jbrunet@baylibre.com>
References: <20170921171450.27407-1-jbrunet@baylibre.com>
Message-ID: <20170921171450.27407-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIOX22 is now declared properly and TEST_N has been moved so
the gpio-line-names of the nanopi-k2 must be adjusted accordingly

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 9697a7a79464..3c445030ed52 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -180,7 +180,9 @@
 			  "VCCK En", "CON1 Header Pin31",
 			  "I2S Header Pin6", "IR In", "I2S Header Pin7",
 			  "I2S Header Pin3", "I2S Header Pin4",
-			  "I2S Header Pin5", "HDMI CEC", "SYS LED";
+			  "I2S Header Pin5", "HDMI CEC", "SYS LED",
+			  /* GPIO_TEST_N */
+			  "";
 };
 
 &pinctrl_periphs {
@@ -226,11 +228,9 @@
 			  "Bluetooth UART TX", "Bluetooth UART RX",
 			  "Bluetooth UART CTS", "Bluetooth UART RTS",
 			  "", "", "", "WIFI 32K", "Bluetooth Enable",
-			  "Bluetooth WAKE HOST",
+			  "Bluetooth WAKE HOST", "",
 			  /* Bank GPIOCLK */
-			  "", "CON1 Header Pin35", "", "",
-			  /* GPIO_TEST_N */
-			  "";
+			  "", "CON1 Header Pin35", "", "";
 };
 
 &pwm_ef {
-- 
2.13.5
