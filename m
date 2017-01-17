From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 17 Jan 2017 14:12:36 -0200
Subject: [PATCH v3 4/5] ARM: dts: stm32: Enable USB HS in FS mode (embedded
 phy) on stm32f429-disco
In-Reply-To: <20170117161237.3802-1-bruherrera@gmail.com>
References: <20170117161237.3802-1-bruherrera@gmail.com>
Message-ID: <20170117161237.3802-5-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB HS working in FS mode on stm32f429-disco 
with 5V VBUS enable.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 7d0415e..0b2b017 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -88,6 +88,14 @@
 			gpios = <&gpioa 0 0>;
 		};
 	};
+
+	/* This turns on vbus for otg for host mode (dwc2) */
+	vcc5v_otg: vcc5v-otg-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpioc 4 0>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+	};
 };
 
 &clk_hse {
@@ -99,3 +107,11 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbotg_hs {
+	compatible = "st,stm32f4xx-fsotg";
+	dr_mode = "host";
+	pinctrl-0 = <&usbotg_fs_pins_b>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.10.1 (Apple Git-78)
