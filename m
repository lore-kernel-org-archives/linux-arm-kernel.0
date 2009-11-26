From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 26 Nov 2009 20:13:47 +0100
Subject: [PATCH 1/3] ARM: pxa/raumfeld: add platform support
In-Reply-To: <1259258341-31114-2-git-send-email-daniel@caiaq.de>
References: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
	<1259258341-31114-2-git-send-email-daniel@caiaq.de>
Message-ID: <200911262013.47713.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 26. listopadu 2009 18:58:59 Daniel Mack napsal(a):
> This adds support for Raumfeld's 'Controller', 'Connector', 'Speaker S'
> and 'Speaker M' devices. They're all based on PXA303 SoCs.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
...
> +/*
> + * GPIO configurations
> + */
> +static mfp_cfg_t __raumfeld_controller_pin_config[] = {
> +	/* UART1 */
> +	GPIO77_UART1_RXD,
> +	GPIO78_UART1_TXD,
> +	GPIO79_UART1_CTS,
> +	GPIO81_UART1_DSR,
> +	GPIO83_UART1_DTR,
> +	GPIO84_UART1_RTS,
> +
> +	/* UART3 */
> +	GPIO110_UART3_RXD,
> +
> +	/* USB Host */
> +	GPIO0_2_USBH_PEN,
> +	GPIO1_2_USBH_PWR,
> +
> +	/* I2C */
> +	GPIO21_I2C_SCL | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +	GPIO22_I2C_SDA | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +
> +	/* SPI */
> +	GPIO34_GPIO,	/* SPDIF_CS */
> +	GPIO96_GPIO,	/* MCLK_CS */
> +	GPIO125_GPIO,	/* ACCEL_CS */
> +
> +	/* MMC */
> +	GPIO3_MMC1_DAT0,
> +	GPIO4_MMC1_DAT1,
> +	GPIO5_MMC1_DAT2,
> +	GPIO6_MMC1_DAT3,
> +	GPIO7_MMC1_CLK,
> +	GPIO8_MMC1_CMD,
> +
> +	/* One-wire */
> +	GPIO126_GPIO | MFP_LPM_FLOAT,
> +	GPIO105_GPIO | MFP_PULL_LOW | MFP_LPM_PULL_LOW,
> +
> +	/* CHRG_USB_OK */
> +	GPIO101_GPIO | MFP_PULL_HIGH,
> +	/* CHRG_USB_OK */
> +	GPIO112_GPIO | MFP_PULL_HIGH,
> +	/* CHRG_USB_SUSP */
> +	GPIO102_GPIO,
> +	/* DISPLAY_ENABLE */
> +	GPIO106_GPIO,
> +	/* DOCK_DETECT */
> +	GPIO116_GPIO | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +
> +	/* LCD */
> +	GPIO54_LCD_LDD_0,
> +	GPIO55_LCD_LDD_1,
> +	GPIO56_LCD_LDD_2,
> +	GPIO57_LCD_LDD_3,
> +	GPIO58_LCD_LDD_4,
> +	GPIO59_LCD_LDD_5,
> +	GPIO60_LCD_LDD_6,
> +	GPIO61_LCD_LDD_7,
> +	GPIO62_LCD_LDD_8,
> +	GPIO63_LCD_LDD_9,
> +	GPIO64_LCD_LDD_10,
> +	GPIO65_LCD_LDD_11,
> +	GPIO66_LCD_LDD_12,
> +	GPIO67_LCD_LDD_13,
> +	GPIO68_LCD_LDD_14,
> +	GPIO69_LCD_LDD_15,
> +	GPIO70_LCD_LDD_16,
> +	GPIO71_LCD_LDD_17,
> +	GPIO72_LCD_FCLK,
> +	GPIO73_LCD_LCLK,
> +	GPIO74_LCD_PCLK,
> +	GPIO75_LCD_BIAS,
> +};
> +
> +static mfp_cfg_t __raumfeld_connector_pin_config[] = {
> +	/* UART1 */
> +	GPIO77_UART1_RXD,
> +	GPIO78_UART1_TXD,
> +	GPIO79_UART1_CTS,
> +	GPIO81_UART1_DSR,
> +	GPIO83_UART1_DTR,
> +	GPIO84_UART1_RTS,
> +
> +	/* UART3 */
> +	GPIO110_UART3_RXD,
> +
> +	/* USB Host */
> +	GPIO0_2_USBH_PEN,
> +	GPIO1_2_USBH_PWR,
> +
> +	/* I2C */
> +	GPIO21_I2C_SCL | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +	GPIO22_I2C_SDA | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +
> +	/* SPI */
> +	GPIO34_GPIO,	/* SPDIF_CS */
> +	GPIO96_GPIO,	/* MCLK_CS */
> +	GPIO125_GPIO,	/* ACCEL_CS */
> +
> +	/* MMC */
> +	GPIO3_MMC1_DAT0,
> +	GPIO4_MMC1_DAT1,
> +	GPIO5_MMC1_DAT2,
> +	GPIO6_MMC1_DAT3,
> +	GPIO7_MMC1_CLK,
> +	GPIO8_MMC1_CMD,
> +
> +	/* Ethernet */
> +	GPIO1_nCS2,			/* CS */
> +	GPIO40_GPIO | MFP_PULL_HIGH,	/* IRQ */
> +
> +	/* SSP for I2S */
> +	GPIO85_SSP1_SCLK,
> +	GPIO89_SSP1_EXTCLK,
> +	GPIO86_SSP1_FRM,
> +	GPIO87_SSP1_TXD,
> +	GPIO88_SSP1_RXD,
> +	GPIO90_SSP1_SYSCLK,
> +
> +	/* SSP2 for S/PDIF */
> +	GPIO25_SSP2_SCLK,
> +	GPIO26_SSP2_FRM,
> +	GPIO27_SSP2_TXD,
> +	GPIO29_SSP2_EXTCLK,
> +};
> +
> +static mfp_cfg_t __raumfeld_speaker_pin_config[] = {
> +	/* UART1 */
> +	GPIO77_UART1_RXD,
> +	GPIO78_UART1_TXD,
> +	GPIO79_UART1_CTS,
> +	GPIO81_UART1_DSR,
> +	GPIO83_UART1_DTR,
> +	GPIO84_UART1_RTS,
> +
> +	/* UART3 */
> +	GPIO110_UART3_RXD,
> +
> +	/* USB Host */
> +	GPIO0_2_USBH_PEN,
> +	GPIO1_2_USBH_PWR,
> +
> +	/* I2C */
> +	GPIO21_I2C_SCL | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +	GPIO22_I2C_SDA | MFP_LPM_FLOAT | MFP_PULL_FLOAT,
> +
> +	/* SPI */
> +	GPIO34_GPIO,	/* SPDIF_CS */
> +	GPIO96_GPIO,	/* MCLK_CS */
> +	GPIO125_GPIO,	/* ACCEL_CS */
> +
> +	/* MMC */
> +	GPIO3_MMC1_DAT0,
> +	GPIO4_MMC1_DAT1,
> +	GPIO5_MMC1_DAT2,
> +	GPIO6_MMC1_DAT3,
> +	GPIO7_MMC1_CLK,
> +	GPIO8_MMC1_CMD,
> +
> +	/* Ethernet */
> +	GPIO1_nCS2,			/* CS */
> +	GPIO40_GPIO | MFP_PULL_HIGH,	/* IRQ */
> +
> +	/* SSP for I2S */
> +	GPIO85_SSP1_SCLK,
> +	GPIO89_SSP1_EXTCLK,
> +	GPIO86_SSP1_FRM,
> +	GPIO87_SSP1_TXD,
> +	GPIO88_SSP1_RXD,
> +	GPIO90_SSP1_SYSCLK,
> +};
> +
> +/*
...

Why don't we separate the common MFP configuration into another table as some 
platforms do ? The code duplication is horrible here ...
