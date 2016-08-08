From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Aug 2016 15:08:03 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx53: add support for USB armory board
In-Reply-To: <20160628125444.16531-3-andrej@inversepath.com>
References: <20160628125444.16531-1-andrej@inversepath.com>
 <20160628125444.16531-3-andrej@inversepath.com>
Message-ID: <20160808070803.GB4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more comment below.

On Tue, Jun 28, 2016 at 02:54:44PM +0200, andrej at inversepath.com wrote:
> +&iomuxc {
> +	pinctrl_esdhc1: esdhc1grp {
> +		fsl,pins = <
> +			MX53_PAD_SD1_DATA0__ESDHC1_DAT0		0x1d5
> +			MX53_PAD_SD1_DATA1__ESDHC1_DAT1		0x1d5
> +			MX53_PAD_SD1_DATA2__ESDHC1_DAT2		0x1d5
> +			MX53_PAD_SD1_DATA3__ESDHC1_DAT3		0x1d5
> +			MX53_PAD_SD1_CMD__ESDHC1_CMD		0x1d5
> +			MX53_PAD_SD1_CLK__ESDHC1_CLK		0x1d5
> +		>;
> +	};
> +
> +	pinctrl_i2c1_pmic: i2c1grp_pmic {
> +		fsl,pins = <
> +			MX53_PAD_EIM_D21__I2C1_SCL	0x0
> +			MX53_PAD_EIM_D28__I2C1_SDA	0x0

Please use a proper pin configuration value rather than 0x0.

> +		>;
> +	};
> +
> +	pinctrl_led: led {
> +		fsl,pins = <
> +			MX53_PAD_DISP0_DAT6__GPIO4_27 0x0

Ditto.

Shawn

> +		>;
> +	};
