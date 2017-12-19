From: robertcnelson@gmail.com (Robert Nelson)
Date: Tue, 19 Dec 2017 16:32:42 -0600
Subject: [PATCH 3/3] ARM: dts: am335x-boneblue: enable can
In-Reply-To: <20171219223242.21386-1-robertcnelson@gmail.com>
References: <20171219223242.21386-1-robertcnelson@gmail.com>
Message-ID: <20171219223242.21386-3-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BeagleBone Blue: can: enable the dedicated can connector.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-boneblue.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index ad988e8b8427..3f2480d05a3b 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -252,6 +252,15 @@
 			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
 		>;
 	};
+
+	/* DCAN */
+	dcan1_pins: pinmux_dcan1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE2)		/* (E17) uart0_rtsn.dcan1_rx */
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)		/* (E18) uart0_ctsn.dcan1_tx */
+			AM33XX_IOPAD(0x940, PIN_OUTPUT | MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
+		>;
+	};
 };
 
 &uart0 {
@@ -510,6 +519,12 @@
 	clock-names = "ext-clk", "int-clk";
 };
 
+&dcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins>;
+	status = "okay";
+};
+
 &gpio3 {
 	ls_buf_en {
 		gpio-hog;
-- 
2.15.1
