From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 13 Nov 2016 18:12:09 +0000
Subject: [PATCH 2/2] ARM: bcm2835: Add names for the Raspberry Pi Zero GPIO
 lines
In-Reply-To: <1479060729-25769-1-git-send-email-stefan.wahren@i2se.com>
References: <1479060729-25769-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1479060729-25769-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the GPIO names for the Raspberry Pi Zero. Since there are no
schematics for the RPi Zero use the same as the Model A+.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi |   75 +++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts       |   76 +-----------------------
 arch/arm/boot/dts/bcm2835-rpi-zero.dts         |   11 +---
 3 files changed, 77 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi b/arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi
new file mode 100644
index 0000000..741d64d
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi
@@ -0,0 +1,75 @@
+&gpio {
+	/*
+	 * This is based on the unreleased schematic for the Model A+.
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "SDA0",
+			  "SCL0",
+			  "SDA1",
+			  "SCL1",
+			  "GPIO_GCLK",
+			  "GPIO5",
+			  "GPIO6",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "GPIO12",
+			  "GPIO13",
+			  /* Serial port */
+			  "TXD0",
+			  "RXD0",
+			  "GPIO16",
+			  "GPIO17",
+			  "GPIO18",
+			  "GPIO19",
+			  "GPIO20",
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "GPIO26",
+			  "GPIO27",
+			  "SDA0",
+			  "SCL0",
+			  "NC", /* GPIO30 */
+			  "NC", /* GPIO31 */
+			  "CAM_GPIO1", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "PWR_LOW_N", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "USB_LIMIT", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "PWM0_OUT", /* GPIO40 */
+			  "CAM_GPIO0", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "PWM1_OUT", /* GPIO45 */
+			  "HDMI_HPD_N",
+			  "STATUS_LED",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
+
+	/* I2S interface */
+	i2s_alt0: i2s_alt0 {
+		brcm,pins = <18 19 20 21>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index d070454..9b665da 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -2,6 +2,7 @@
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
+#include "bcm2835-rpi-a-plus-gpio.dtsi"
 
 / {
 	compatible = "raspberrypi,model-a-plus", "brcm,bcm2835";
@@ -21,81 +22,6 @@
 	};
 };
 
-&gpio {
-	/*
-	 * This is based on the unreleased schematic for the Model A+.
-	 *
-	 * Legend:
-	 * "NC" = not connected (no rail from the SoC)
-	 * "FOO" = GPIO line named "FOO" on the schematic
-	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
-	 */
-	gpio-line-names = "SDA0",
-			  "SCL0",
-			  "SDA1",
-			  "SCL1",
-			  "GPIO_GCLK",
-			  "GPIO5",
-			  "GPIO6",
-			  "SPI_CE1_N",
-			  "SPI_CE0_N",
-			  "SPI_MISO",
-			  "SPI_MOSI",
-			  "SPI_SCLK",
-			  "GPIO12",
-			  "GPIO13",
-			  /* Serial port */
-			  "TXD0",
-			  "RXD0",
-			  "GPIO16",
-			  "GPIO17",
-			  "GPIO18",
-			  "GPIO19",
-			  "GPIO20",
-			  "GPIO21",
-			  "GPIO22",
-			  "GPIO23",
-			  "GPIO24",
-			  "GPIO25",
-			  "GPIO26",
-			  "GPIO27",
-			  "SDA0",
-			  "SCL0",
-			  "NC", /* GPIO30 */
-			  "NC", /* GPIO31 */
-			  "CAM_GPIO1", /* GPIO32 */
-			  "NC", /* GPIO33 */
-			  "NC", /* GPIO34 */
-			  "PWR_LOW_N", /* GPIO35 */
-			  "NC", /* GPIO36 */
-			  "NC", /* GPIO37 */
-			  "USB_LIMIT", /* GPIO38 */
-			  "NC", /* GPIO39 */
-			  "PWM0_OUT", /* GPIO40 */
-			  "CAM_GPIO0", /* GPIO41 */
-			  "NC", /* GPIO42 */
-			  "NC", /* GPIO43 */
-			  "NC", /* GPIO44 */
-			  "PWM1_OUT", /* GPIO45 */
-			  "HDMI_HPD_N",
-			  "STATUS_LED",
-			  /* Used by SD Card */
-			  "SD_CLK_R",
-			  "SD_CMD_R",
-			  "SD_DATA0_R",
-			  "SD_DATA1_R",
-			  "SD_DATA2_R",
-			  "SD_DATA3_R";
-
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
-
-	/* I2S interface */
-	i2s_alt0: i2s_alt0 {
-		brcm,pins = <18 19 20 21>;
-		brcm,function = <BCM2835_FSEL_ALT0>;
-	};
-};
-
 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index 7c1c180..0154ae0 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -13,6 +13,7 @@
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
+#include "bcm2835-rpi-a-plus-gpio.dtsi"
 
 / {
 	compatible = "raspberrypi,model-zero", "brcm,bcm2835";
@@ -25,16 +26,6 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
-
-	/* I2S interface */
-	i2s_alt0: i2s_alt0 {
-		brcm,pins = <18 19 20 21>;
-		brcm,function = <BCM2835_FSEL_ALT0>;
-	};
-};
-
 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
 };
-- 
1.7.9.5
