From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Aug 2013 18:21:25 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130827182125.7437e679154062236160283e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/am335x-evmsk.dts between commit 97238b35d5bb ("usb:
musb: dsps: use proper child nodes") from the usb tree and commit
63f6b2550aa0 ("ARM: dts: AM33XX: don't redefine OCP bus and device
nodes") from the arm-soc tree.

I fixed it up (probably incorrectly - see below) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am335x-evmsk.dts
index e92446c,8e7279b..0000000
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@@ -30,210 -30,6 +30,24 @@@
  		reg = <0x80000000 0x10000000>; /* 256 MB */
  	};
  
- 	am33xx_pinmux: pinmux at 44e10800 {
- 		pinctrl-names = "default";
- 		pinctrl-0 = <&gpio_keys_s0 &clkout2_pin>;
- 
- 		user_leds_s0: user_leds_s0 {
- 			pinctrl-single,pins = <
- 				0x10 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
- 				0x14 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
- 				0x18 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
- 				0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
- 			>;
- 		};
- 
- 		gpio_keys_s0: gpio_keys_s0 {
- 			pinctrl-single,pins = <
- 				0x94 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_oen_ren.gpio2_3 */
- 				0x90 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_advn_ale.gpio2_2 */
- 				0x70 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
- 				0x9c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ben0_cle.gpio2_5 */
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
- 				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
- 			>;
- 		};
- 
- 		clkout2_pin: pinmux_clkout2_pin {
- 			pinctrl-single,pins = <
- 				0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)		/* xdma_event_intr1.clkout2 */
- 			>;
- 		};
- 
- 		ecap2_pins: backlight_pins {
- 			pinctrl-single,pins = <
- 				0x19c 0x4	/* mcasp0_ahclkr.ecap2_in_pwm2_out MODE4 */
- 			>;
- 		};
- 
- 		cpsw_default: cpsw_default {
- 			pinctrl-single,pins = <
- 				/* Slave 1 */
- 				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
- 				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
- 				0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
- 				0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
- 				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
- 				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
- 				0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
- 				0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
- 				0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
- 				0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
- 				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
- 				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
- 
- 				/* Slave 2 */
- 				0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
- 				0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
- 				0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
- 				0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
- 				0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
- 				0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
- 				0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
- 				0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
- 				0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
- 				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
- 				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
- 				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
- 			>;
- 		};
- 
- 		cpsw_sleep: cpsw_sleep {
- 			pinctrl-single,pins = <
- 				/* Slave 1 reset value */
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
- 
- 				/* Slave 2 reset value*/
- 				0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
- 				0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
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
- 		i2c0: i2c at 44e0b000 {
- 			pinctrl-names = "default";
- 			pinctrl-0 = <&i2c0_pins>;
- 
- 			status = "okay";
- 			clock-frequency = <400000>;
- 
- 			tps: tps at 2d {
- 				reg = <0x2d>;
- 			};
- 
- 			lis331dlh: lis331dlh at 18 {
- 				compatible = "st,lis331dlh", "st,lis3lv02d";
- 				reg = <0x18>;
- 				Vdd-supply = <&lis3_reg>;
- 				Vdd_IO-supply = <&lis3_reg>;
- 
- 				st,click-single-x;
- 				st,click-single-y;
- 				st,click-single-z;
- 				st,click-thresh-x = <10>;
- 				st,click-thresh-y = <10>;
- 				st,click-thresh-z = <10>;
- 				st,irq1-click;
- 				st,irq2-click;
- 				st,wakeup-x-lo;
- 				st,wakeup-x-hi;
- 				st,wakeup-y-lo;
- 				st,wakeup-y-hi;
- 				st,wakeup-z-lo;
- 				st,wakeup-z-hi;
- 				st,min-limit-x = <120>;
- 				st,min-limit-y = <120>;
- 				st,min-limit-z = <140>;
- 				st,max-limit-x = <550>;
- 				st,max-limit-y = <550>;
- 				st,max-limit-z = <750>;
- 			};
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
- 		epwmss2: epwmss at 48304000 {
- 			status = "okay";
- 
- 			ecap2: ecap at 48304100 {
- 				status = "okay";
- 				pinctrl-names = "default";
- 				pinctrl-0 = <&ecap2_pins>;
- 			};
- 		};
 +	};
 +
  	vbat: fixedregulator at 0 {
  		compatible = "regulator-fixed";
  		regulator-name = "vbat";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/9f79546b/attachment.sig>
