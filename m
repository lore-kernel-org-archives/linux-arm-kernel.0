From: eric@anholt.net (Eric Anholt)
Date: Thu, 27 Oct 2016 09:52:46 -0700
Subject: [PATCH v3] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
Message-ID: <20161027165246.23936-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The idea is to give useful names to GPIO lines that an implementer
will be using from userspace, e.g. for maker type projects.  These are
user-visible using tools/gpio/lsgpio.c

v2: Major rewrite by anholt: Flatten each GPIO line to a line in the
    file for better diffing, prefix all expansion header pins with
    "P<number>" or "P5HEADER_P<number>" and drop the mostly-unused
    GPIO_GEN<smallnumber> names in favor of GPIO<socgpionumber>, fix
    extra '[]' on a couple of lines, fix locations of SD_CARD_DETECT,
    CAM_GPIO and STATUS_LED, fix HDMI_HPD polarities, rewrite A+ using
    unreleased schematics.

v3: More changes by anholt: Drop P<number> / P5HEADER<number>
    prefixes.  I had been skeptical about adding them, and was
    convinced to drop them by Gottfried (who probably has more
    experience with GPIOs in educational contexts than the rest of
    us).  Also drop [] brackets for "is pinmuxed", which didn't seem
    to clarify, and were ambiguous for things like the SPI_*-labeled
    pins which may or may not actually be pinmuxed to SPI.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 65 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 67 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 66 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 66 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 67 ++++++++++++++++++++++++++++++++
 5 files changed, 331 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 21507c922783..5a22c7965f34 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -22,6 +22,71 @@
 };
 
 &gpio {
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
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "PWR_LOW_N", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
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
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 5afba0900449..54f98c59a75d 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -15,6 +15,73 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-Rev-1.0-Model-AB-Schematics.pdf
+	 * RPI00021 sheet 02
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
+			  "CAM_CLK",
+			  "LAN_RUN",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "NC", /* GPIO12 */
+			  "NC", /* GPIO13 */
+			  /* Serial port */
+			  "TXD0",
+			  "RXD0",
+			  "STATUS_LED_N",
+			  "GPIO17",
+			  "GPIO18",
+			  "NC", /* GPIO19 */
+			  "NC", /* GPIO20 */
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "NC", /* GPIO26 */
+			  "CAM_GPIO",
+			  /* Binary number representing build/revision */
+			  "CONFIG0",
+			  "CONFIG1",
+			  "CONFIG2",
+			  "CONFIG3",
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "PWM0_OUT",
+			  "NC", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "PWM1_OUT",
+			  "HDMI_HPD_P",
+			  "SD_CARD_DET",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 38f66aa244fe..f4bd78352a28 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -23,6 +23,72 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-B-Plus-V1.2-Schematics.pdf
+	 * RPI-BPLUS sheet 1
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "ID_SD",
+			  "ID_SC",
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
+			  "LAN_RUN", /* GPIO31 */
+			  "CAM_GPIO1", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "PWR_LOW_N", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "PWM0_OUT", /* GPIO40 */
+			  "CAM_GPIO0", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "ETHCLK", /* GPIO44 */
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
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 75e045aba7ce..9d1d4c6ce1f0 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -16,6 +16,72 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-Rev-2.0-Model-AB-Schematics.pdf
+	 * RPI00022 sheet 02
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
+			  "CAM_CLK",
+			  "LAN_RUN",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "NC", /* GPIO12 */
+			  "NC", /* GPIO13 */
+			  /* Serial port */
+			  "TXD0",
+			  "RXD0",
+			  "STATUS_LED_N",
+			  "GPIO17",
+			  "GPIO18",
+			  "NC", /* GPIO19 */
+			  "NC", /* GPIO20 */
+			  "CAM_GPIO",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "NC", /* GPIO 26 */
+			  "GPIO27",
+			  "GPIO28",
+			  "GPIO29",
+			  "GPIO30",
+			  "GPIO31",
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "PWM0_OUT",
+			  "NC", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "PWM1_OUT",
+			  "HDMI_HPD_P",
+			  "SD_CARD_DET",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 76a254b3219a..71f50e16c646 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -16,6 +16,73 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-Rev-1.0-Model-AB-Schematics.pdf
+	 * RPI00021 sheet 02
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
+			  "CAM_CLK",
+			  "LAN_RUN",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "NC", /* GPIO12 */
+			  "NC", /* GPIO13 */
+			  /* Serial port */
+			  "TXD0",
+			  "RXD0",
+			  "STATUS_LED_N",
+			  "GPIO17",
+			  "GPIO18",
+			  "NC", /* GPIO19 */
+			  "NC", /* GPIO20 */
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "NC", /* GPIO26 */
+			  "CAM_GPIO",
+			  /* Binary number representing build/revision */
+			  "CONFIG0",
+			  "CONFIG1",
+			  "CONFIG2",
+			  "CONFIG3",
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "PWM0_OUT",
+			  "NC", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "PWM1_OUT",
+			  "HDMI_HPD_P",
+			  "SD_CARD_DET",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
-- 
2.9.3
