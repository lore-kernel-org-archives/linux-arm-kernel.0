From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 25 Sep 2015 17:44:12 -0700
Subject: [PATCH v6 6/6] pinctrl: freescale: imx: imx7d iomuxc-lpsr
 devicetree bindings
In-Reply-To: <1443215162-13716-6-git-send-email-aalonso@freescale.com>
References: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
 <1443215162-13716-6-git-send-email-aalonso@freescale.com>
Message-ID: <20150926004411.GE3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 04:06:02PM -0500, Adrian Alonso wrote:
> +Examples:
> +While iomuxc-lpsr is intended to be used by dedicated peripherals to take
> +advantages of LPSR power mode, is also possible that an IP to use pads from
> +any of the iomux controllers. For example the I2C1 IP can use SCL pad from
> +iomuxc-lpsr controller and SDA pad from iomuxc controller as:
> +
> +i2c1: i2c at 30a20000 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_1 &pinctrl_i2c1_2>;
> +	status = "okay";
> +};
> +
> +iomuxc-lpsr at 302c0000 {
> +	compatible = "fsl,imx7d-iomuxc-lpsr";
> +	reg = <0x302c0000 0x10000>;
> +	fsl,input-sel = <&iomuxc>;
> +
> +	pinctrl_i2c1_1: i2c1grp-1 {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO04__I2C1_SCL 0x4000007f
> +		>;
> +	};
> +};
> +
> +iomuxc at 30330000 {
> +	compatible = "fsl,imx7d-iomuxc";
> +	reg = <0x30330000 0x10000>;
> +
> +	pinctrl_i2c1_2: i2c1grp-2 {
> +		fsl,pins = <
> +			MX7D_PAD_I2C1_SCL__I2C1_SCL 0x4000007f

I thought you have fixed this, as I have pointed it out during the last
review.  The example doesn't make sense.  There is no reason you need to
have two pads on the same function I2C1_SCL.  One of them should be
I2C1_SDA.

Shawn

> +		>;
> +	};
> +};
> -- 
> 2.1.4
> 
