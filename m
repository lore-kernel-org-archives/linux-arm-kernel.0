From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Aug 2013 18:13:53 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130827181353.319c150858829df1bb68d60b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/am335x-bone.dts between commit 97238b35d5bb ("usb:
musb: dsps: use proper child nodes") from the  tree and commit
63f6b2550aa0 ("ARM: dts: AM33XX: don't redefine OCP bus and device
nodes") from the arm-soc tree.

I fixed it up (probably incorrectly - see below) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am335x-bone.dts
index a8907b5,d99be03..0000000
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@@ -24,132 -24,6 +24,24 @@@
  		reg = <0x80000000 0x10000000>; /* 256 MB */
  	};
  
- 	am33xx_pinmux: pinmux at 44e10800 {
- 		pinctrl-names = "default";
- 		pinctrl-0 = <&clkout2_pin>;
- 
- 		user_leds_s0: user_leds_s0 {
- 			pinctrl-single,pins = <
- 				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
- 				0x58 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
- 				0x5c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
- 				0x60 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
- 			>;
- 		};
- 
- 		i2c0_pins: pinmux_i2c0_pins {
- 			pinctrl-single,pins = <
- 				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
- 				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
- 			>;
- 		};
- 
- 		uart0_pins: pinmux_uart0_pins {
- 			pinctrl-single,pins = <
- 				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
- 				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
- 			>;
- 		};
- 
- 		clkout2_pin: pinmux_clkout2_pin {
- 			pinctrl-single,pins = <
- 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
- 			>;
- 		};
- 
- 		cpsw_default: cpsw_default {
- 			pinctrl-single,pins = <
- 				/* Slave 1 */
- 				0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxerr.mii1_rxerr */
- 				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txen.mii1_txen */
- 				0x118 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxdv.mii1_rxdv */
- 				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd3.mii1_txd3 */
- 				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd2.mii1_txd2 */
- 				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd1.mii1_txd1 */
- 				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mii1_txd0.mii1_txd0 */
- 				0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_txclk.mii1_txclk */
- 				0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxclk.mii1_rxclk */
- 				0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd3.mii1_rxd3 */
- 				0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd2.mii1_rxd2 */
- 				0x13c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd1.mii1_rxd1 */
- 				0x140 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mii1_rxd0.mii1_rxd0 */
- 			>;
- 		};
- 
- 		cpsw_sleep: cpsw_sleep {
- 			pinctrl-single,pins = <
- 				/* Slave 1 reset value */
- 				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 
- 		davinci_mdio_default: davinci_mdio_default {
- 			pinctrl-single,pins = <
- 				/* MDIO */
- 				0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
- 				0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
- 			>;
- 		};
- 
- 		davinci_mdio_sleep: davinci_mdio_sleep {
- 			pinctrl-single,pins = <
- 				/* MDIO reset value */
- 				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 			>;
- 		};
- 	};
- 
 +	ocp {
- 		uart0: serial at 44e09000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&uart0_pins>;
- 
- 			status = "okay";
- 		};
- 
 +		musb: usb at 47400000 {
 +			status = "okay";
 +
 +			control at 44e10000 {
 +				status = "okay";
 +			};
 +
 +			phy at 47401300 {
 +				status = "okay";
 +			};
 +
 +			usb at 47401000 {
 +				status = "okay";
 +			};
 +		};
- 
- 		i2c0: i2c at 44e0b000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&i2c0_pins>;
- 
- 			status = "okay";
- 			clock-frequency = <400000>;
- 
- 			tps: tps at 24 {
- 				reg = <0x24>;
- 			};
- 
- 		};
 +	};
 +
  	leds {
  		pinctrl-names = "default";
  		pinctrl-0 = <&user_leds_s0>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/345803a4/attachment.sig>
