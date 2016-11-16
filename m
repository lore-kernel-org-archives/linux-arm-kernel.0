From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 16 Nov 2016 17:52:07 +0000
Subject: [PATCH V2 2/2] ARM: bcm2835: Add names for the RPi Zero GPIO lines
In-Reply-To: <1479318727-9425-1-git-send-email-stefan.wahren@i2se.com>
References: <1479318727-9425-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1479318727-9425-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the GPIO names for the Raspberry Pi Zero. The GPIO lines
of the RPi Zero are almost identical to the Model A+ except:

* GPIO 35, 38, 40 and 45 are not connected
* Status LED is active low

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-zero.dts |   65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index 7c1c180..fa7997a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -26,6 +26,71 @@
 };
 
 &gpio {
+	/*
+	 * This is based on the official GPU firmware DT blob.
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
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "NC", /* GPIO40 */
+			  "CAM_GPIO0", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "NC", /* GPIO45 */
+			  "HDMI_HPD_N",
+			  "STATUS_LED_N",
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
-- 
1.7.9.5
