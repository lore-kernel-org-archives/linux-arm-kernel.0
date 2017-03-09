From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  9 Mar 2017 15:52:45 +0100
Subject: [PATCH 1/2] ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names
In-Reply-To: <1489071166-11476-1-git-send-email-narmstrong@baylibre.com>
References: <1489071166-11476-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489071166-11476-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes the GPIO lines usage on the Odroid-C2 board.

This is useful in the debugfs gpio file and using the cdev gpio API.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c59403a..def5aed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -165,6 +165,57 @@
 	};
 };
 
+&pinctrl_aobus {
+	gpio-line-names = "UART TX", "UART RX", "VCCK En", "TF 3V3/1V8 En",
+			  "USB HUB nRESET", "USB OTG Power En",
+			  "J7 Header Pin2", "IR In", "J7 Header Pin4",
+			  "J7 Header Pin6", "J7 Header Pin5", "J7 Header Pin7",
+			  "HDMI CEC", "SYS LED";
+};
+
+&pinctrl_periphs {
+	gpio-line-names = /* Bank GPIOZ */
+			  "Eth MDIO", "Eth MDC", "Eth RGMII RX Clk",
+			  "Eth RX DV", "Eth RX D0", "Eth RX D1", "Eth RX D2",
+			  "Eth RX D3", "Eth RGMII TX Clk", "Eth TX En",
+			  "Eth TX D0", "Eth TX D1", "Eth TX D2", "Eth TX D3",
+			  "Eth PHY nRESET", "Eth PHY Intc",
+			  /* Bank GPIOH */
+			  "HDMI HPD", "HDMI DDC SDA", "HDMI DDC SCL", "",
+			  /* Bank BOOT */
+			  "eMMC D0", "eMMC D1", "eMMC D2", "eMMC D3", "eMMC D4",
+			  "eMMC D5", "eMMC D6", "eMMC D7", "eMMC Clk",
+			  "eMMC Reset", "eMMC CMD",
+			  "", "", "", "", "", "", "",
+			  /* Bank CARD */
+			  "SDCard D1", "SDCard D0", "SDCard CLK", "SDCard CMD",
+			  "SDCard D3", "SDCard D2", "SDCard Det",
+			  /* Bank GPIODV */
+			  "", "", "", "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "", "",
+			  "I2C A SDA", "I2C A SCK", "I2C B SDA", "I2C B SCK",
+			  "PWM D", "PWM B",
+			  /* Bank GPIOY */
+			  "Revision Bit0", "Revision Bit1", "",
+			  "J2 Header Pin35", "", "", "", "J2 Header Pin36",
+			  "J2 Header Pin31", "", "", "", "TF VDD En",
+			  "J2 Header Pin32", "J2 Header Pin26", "", "",
+			  /* Bank GPIOX */
+			  "J2 Header Pin29", "J2 Header Pin24",
+			  "J2 Header Pin23", "J2 Header Pin22",
+			  "J2 Header Pin21", "J2 Header Pin18",
+			  "J2 Header Pin33", "J2 Header Pin19",
+			  "J2 Header Pin16", "J2 Header Pin15",
+			  "J2 Header Pin12", "J2 Header Pin13",
+			  "J2 Header Pin8", "J2 Header Pin10",
+			  "", "", "", "", "",
+			  "J2 Header Pin11", "", "J2 Header Pin7",
+			  /* Bank GPIOCLK */
+			  "", "", "", "",
+			  /* GPIO_TEST_N */
+			  "";
+};
+
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
-- 
1.9.1
