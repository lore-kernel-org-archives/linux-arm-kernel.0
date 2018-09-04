From: christianshewitt@gmail.com (chewitt)
Date: Tue,  4 Sep 2018 18:44:50 +0400
Subject: [PATCH] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
Message-ID: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds the ttyAML1 uart used by the brmcfmac sdio module in
the WeTek Hub and WeTek Play 2 devices.

Signed-off-by: chewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 70325b2..9476868 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -10,6 +10,7 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 		ethernet0 = &ethmac;
 	};
 
@@ -239,6 +240,13 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+};
+
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
-- 
2.7.4
