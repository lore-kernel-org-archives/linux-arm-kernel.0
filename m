From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 17 Jan 2017 14:12:35 -0200
Subject: [PATCH v3 3/5] ARM: dts: stm32: Enable USB FS on stm32f469-disco
In-Reply-To: <20170117161237.3802-1-bruherrera@gmail.com>
References: <20170117161237.3802-1-bruherrera@gmail.com>
Message-ID: <20170117161237.3802-4-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB FS on stm32f469-disco with 5V VBUS enable.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8877c00..3e0a83e 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -68,6 +68,15 @@
 	soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
+
+	/* This turns on vbus for otg for host mode (dwc2) */
+	vcc5v_otg: vcc5v-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpiob 2 0>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+	};
 };
 
 &rcc {
@@ -81,3 +90,10 @@
 &usart3 {
 	status = "okay";
 };
+
+&usbotg_fs {
+	dr_mode = "host";
+	pinctrl-0 = <&usbotg_fs_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.10.1 (Apple Git-78)
