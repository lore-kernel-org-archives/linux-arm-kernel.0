From: merker@debian.org (Karsten Merker)
Date: Thu, 10 Dec 2015 21:32:00 +0100
Subject: [PATCH 2/3] ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3
 (baseboard SD socket)
In-Reply-To: <1449779521-754-1-git-send-email-merker@debian.org>
References: <1449779521-754-1-git-send-email-merker@debian.org>
Message-ID: <1449779521-754-3-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olimex A20-SOM-EVB is an evaluation board for the Olimex
A20-SOM system-on-module. The baseboard provides a full-size SD
socket (connected to mmc3) in addition to the micro-SD socket on
the SOM itself (which is connected to mmc0).

Enable the mmc3 controller in the dts.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 6562a6bc..6a3d95d 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -176,6 +176,16 @@
 	status = "okay";
 };
 
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olimex_som_evb>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 0 GPIO_ACTIVE_HIGH>; /* PH0 */
+	cd-inverted;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
@@ -198,6 +208,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	mmc3_cd_pin_olimex_som_evb: mmc3_cd_pin at 0 {
+		allwinner,pins = "PH0";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
 };
 
 &reg_ahci_5v {
-- 
2.1.4
