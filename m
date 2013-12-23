From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 23 Dec 2013 11:28:35 +0200
Subject: [PATCH 2/2] ARM: dts: am335x-evmsk: Fix mmc1 support
In-Reply-To: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
References: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1387790915-7217-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl section and cd-gpio to mmc1. Without these the SD card is not
working on EVM-SK board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 50abe53f6887..486880b74831 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -256,6 +256,12 @@
 		>;
 	};
 
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+		>;
+	};
+
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
 			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
@@ -456,6 +462,9 @@
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
 	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 };
 
 &sham {
-- 
1.8.5.2
