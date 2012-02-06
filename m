From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon,  6 Feb 2012 15:53:20 +0100
Subject: [PATCH 1/1] ARM: at91/dt: add Calao DAB-MMX daugther board support
 for USB-A9G20
Message-ID: <1328540001-24337-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

http://www.calao-systems.com/articles.php?lng=en&pg=6099

this daughter board add the following device:
 - Micro-SD socket
 - TTL 3V3 - (Tx/Rx/RTS/CTS)
 - I2C port
 - 0.96" Serial OLED Display Module (over UART)
 - MP3 decoder with Micro & Speakers
 - 4x PB, 4x Leds (Blue), 3x Leds (Green, Orange, Red)

for now we add only the 2 UARTs, 4 Buttons, 7 leds and i2c via DT

used_led1 will not be re-add via DT as it's used by the motherboard too

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi |   97 ++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi

diff --git a/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi b/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
new file mode 100644
index 0000000..60c2a58
--- /dev/null
+++ b/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
@@ -0,0 +1,97 @@
+/*
+ * calao-dab-mmx.dtsi - Device Tree Include file for Calao DAB-MMX Daughter Board
+ *
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2.
+ */
+
+/ {
+	ahb {
+		apb {
+			usart1: serial at fffb4000 {
+				status = "okay";
+			};
+
+			usart3: serial at fffd0000 {
+				status = "okay";
+			};
+
+			i2c-gpio at 0 {
+				status = "okay";
+			};
+
+			leds at 1 {
+				compatible = "gpio-leds";
+
+				user_led1 {
+					label = "user_led1";
+					gpios = <&pioB 20 1>;
+				};
+
+/*
+ * led already used by mother board but active as high
+ *				user_led2 {
+ *					label = "user_led2";
+ *					gpios = <&pioB 21 1>;
+ *				};
+ */
+				user_led3 {
+					label = "user_led3";
+					gpios = <&pioB 22 1>;
+				};
+
+				user_led4 {
+					label = "user_led4";
+					gpios = <&pioB 23 1>;
+				};
+
+				red {
+					label = "red";
+					gpios = <&pioB 24 1>;
+				};
+
+				orange {
+					label = "orange";
+					gpios = <&pioB 30 1>;
+				};
+
+				green {
+					label = "green";
+					gpios = <&pioB 31 1>;
+				};
+			};
+
+			gpio_keys at 1 {
+				compatible = "gpio-keys";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				user_pb1 {
+					label = "user_pb1";
+					gpios = <&pioB 25 1>;
+					linux,code = <0x100>;
+				};
+
+				user_pb2 {
+					label = "user_pb2";
+					gpios = <&pioB 13 1>;
+					linux,code = <0x101>;
+				};
+
+				user_pb3 {
+					label = "user_pb3";
+					gpios = <&pioA 26 1>;
+					linux,code = <0x102>;
+				};
+
+				user_pb4 {
+					label = "user_pb4";
+					gpios = <&pioC 9 1>;
+					linux,code = <0x103>;
+				};
+			};
+
+		};
+	};
+};
-- 
1.7.7
