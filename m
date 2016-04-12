From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 14:38:02 +0800
Subject: [PATCH v5 2/2] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <1459806792-7729-3-git-send-email-andrew@lunn.ch>
References: <1459806792-7729-1-git-send-email-andrew@lunn.ch>
 <1459806792-7729-3-git-send-email-andrew@lunn.ch>
Message-ID: <20160412063802.GA23438@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 11:53:12PM +0200, Andrew Lunn wrote:
> +&iomuxc {

We usually put iomuxc node at the end of the file to make the file a bit
easier for reading.

> +	pinctrl_adc0_ad5: adc0ad5grp {
> +		fsl,pins = <
> +			VF610_PAD_PTC30__ADC0_SE5	0x00a1
> +		>;
> +	};
> +
> +	pinctrl_dspi0: dspi0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB18__DSPI0_CS1	0x1182
> +			VF610_PAD_PTB19__DSPI0_CS0	0x1182
> +			VF610_PAD_PTB20__DSPI0_SIN	0x1181
> +			VF610_PAD_PTB21__DSPI0_SOUT	0x1182
> +			VF610_PAD_PTB22__DSPI0_SCK	0x1182
> +		>;
> +	};
> +
> +	pinctrl_dspi2: dspi2grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD31__DSPI2_CS1	0x1182
> +			VF610_PAD_PTD30__DSPI2_CS0	0x1182
> +			VF610_PAD_PTD29__DSPI2_SIN	0x1181
> +			VF610_PAD_PTD28__DSPI2_SOUT	0x1182
> +			VF610_PAD_PTD27__DSPI2_SCK	0x1182
> +		>;
> +	};
> +
> +	pinctrl_esdhc1: esdhc1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
> +			VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
> +			VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
> +			VF610_PAD_PTA27__ESDHC1_DAT1	0x31ef
> +			VF610_PAD_PTA28__ESDHC1_DATA2	0x31ef
> +			VF610_PAD_PTA29__ESDHC1_DAT3	0x31ef
> +			VF610_PAD_PTA7__GPIO_134	0x219d
> +		>;
> +	};
> +
> +	pinctrl_fec0: fec0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTC0__ENET_RMII0_MDC	0x30d2
> +			VF610_PAD_PTC1__ENET_RMII0_MDIO	0x30d3
> +			VF610_PAD_PTC2__ENET_RMII0_CRS	0x30d1
> +			VF610_PAD_PTC3__ENET_RMII0_RXD1	0x30d1
> +			VF610_PAD_PTC4__ENET_RMII0_RXD0	0x30d1
> +			VF610_PAD_PTC5__ENET_RMII0_RXER	0x30d1
> +			VF610_PAD_PTC6__ENET_RMII0_TXD1	0x30d2
> +			VF610_PAD_PTC7__ENET_RMII0_TXD0	0x30d2
> +			VF610_PAD_PTC8__ENET_RMII0_TXEN	0x30d2
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
> +			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
> +			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
> +			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
> +			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
> +			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
> +			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
> +			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
> +			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
> +			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
> +		>;
> +	};
> +
> +	pinctrl_gpio_e6185_eeprom_sel: pinctrl-gpio-e6185-eeprom-spi0 {
> +		fsl,pins = <
> +			VF610_PAD_PTE27__GPIO_132	0x33e2
> +		>;
> +	};
> +
> +	pinctrl_gpio_spi0: pinctrl-gpio-spi0 {
> +		fsl,pins = <
> +			VF610_PAD_PTB22__GPIO_44	0x33e2
> +			VF610_PAD_PTB21__GPIO_43	0x33e2
> +			VF610_PAD_PTB20__GPIO_42	0x33e1
> +			VF610_PAD_PTB19__GPIO_41	0x33e2
> +			VF610_PAD_PTB18__GPIO_40	0x33e2
> +		>;
> +	};
> +
> +	pinctrl_i2c_mux_reset: pinctrl-i2c-mux-reset {
> +		fsl,pins = <
> +			 VF610_PAD_PTE14__GPIO_119	0x31c2
> +			 >;
> +	};
> +
> +	pinctrl_i2c0: i2c0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB14__I2C0_SCL	0x37ff
> +			VF610_PAD_PTB15__I2C0_SDA	0x37ff
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB16__I2C1_SCL	0x37ff
> +			VF610_PAD_PTB17__I2C1_SDA	0x37ff
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA22__I2C2_SCL	0x37ff
> +			VF610_PAD_PTA23__I2C2_SDA	0x37ff
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA30__I2C3_SCL	0x37ff
> +			VF610_PAD_PTA31__I2C3_SDA	0x37ff
> +		>;
> +	};
> +
> +	pinctrl_leds_debug: pinctrl-leds-debug {
> +		fsl,pins = <
> +			 VF610_PAD_PTD20__GPIO_74	0x31c2
> +			 >;
> +	};
> +
> +	pinctrl_mdio_mux: pinctrl-mdio-mux {
> +		fsl,pins = <
> +			VF610_PAD_PTA18__GPIO_8		0x31c2
> +			VF610_PAD_PTA19__GPIO_9		0x31c2
> +			VF610_PAD_PTB2__GPIO_24		0x31c2
> +			VF610_PAD_PTB3__GPIO_25		0x31c2
> +		>;
> +	};
> +
> +	pinctrl_pca9554_22: pinctrl-pca95540-22 {
> +		fsl,pins = <
> +			VF610_PAD_PTB28__GPIO_98	0x219d
> +		>;
> +	};
> +
> +	pinctrl_pwm0: pwm0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB0__FTM0_CH0	0x1582
> +			VF610_PAD_PTB1__FTM0_CH1	0x1582
> +			VF610_PAD_PTB2__FTM0_CH2	0x1582
> +			VF610_PAD_PTB3__FTM0_CH3	0x1582
> +		>;
> +	};
> +
> +	pinctrl_qspi0: qspi0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
> +			VF610_PAD_PTD8__QSPI0_B_CS0	0x31ff
> +			VF610_PAD_PTD9__QSPI0_B_DATA3	0x31c3
> +			VF610_PAD_PTD10__QSPI0_B_DATA2	0x31c3
> +			VF610_PAD_PTD11__QSPI0_B_DATA1	0x31c3
> +			VF610_PAD_PTD12__QSPI0_B_DATA0	0x31c3
> +		>;
> +	};
> +
> +	pinctrl_uart0: uart0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB10__UART0_TX	0x21a2
> +			VF610_PAD_PTB11__UART0_RX	0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB23__UART1_TX	0x21a2
> +			VF610_PAD_PTB24__UART1_RX	0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD0__UART2_TX	0x21a2
> +			VF610_PAD_PTD1__UART2_RX	0x21a1
> +		>;
> +	};
> +
> +	pinctrl_usb_vbus: pinctrl-usb-vbus {
> +		fsl,pins = <
> +			VF610_PAD_PTA16__GPIO_6	0x31c2
> +		>;
> +	};
> +
> +	pinctrl_usb0_host: usb0-host-grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD6__GPIO_85		0x0062
> +		>;
> +	};
> +};
> +
> +

One new line is enough.

> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart0>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usbdev0 {
> +	disable-over-current;
> +	vbus-supply = <&usb0_vbus>;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbmisc0 {
> +	status = "okay";
> +};
> +
> +&usbmisc1 {
> +	status = "okay";
> +};
> +
> +&usbphy0 {
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	status = "okay";
> +};
> +

No newline at EOF.

All above comments are trivial, so I decided to fix them up and apply
the patch.

Shawn

> -- 
> 2.7.0
> 
> 
