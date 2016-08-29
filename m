From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 09:35:36 +0800
Subject: [PATCH 1/2] ARM: dts: imx7s-warp: Add NFC support
In-Reply-To: <1471357649-2483-1-git-send-email-vanessa.maegima@nxp.com>
References: <1471357649-2483-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <20160829013536.GC30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 11:27:28AM -0300, Vanessa Maegima wrote:
> Add NFC support for NT3H1101W0FHK device.
> 
> Tested by verifying Manufacturer ID (04h) at address 0x00, via i2ctools.

What the code change tells is all about enabling I2C2 device support.
Please update patch subject and commit log.

Shawn

> 
> Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
> ---
>  arch/arm/boot/dts/imx7s-warp.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
> index 92d9c85..71dbece 100644
> --- a/arch/arm/boot/dts/imx7s-warp.dts
> +++ b/arch/arm/boot/dts/imx7s-warp.dts
> @@ -188,6 +188,13 @@
>  	};
>  };
>  
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
>  &i2c4 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -278,6 +285,13 @@
>  		>;
>  	};
>  
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C2_SDA__I2C2_SDA	0x4000007f
> +			MX7D_PAD_I2C2_SCL__I2C2_SCL	0x4000007f
> +		>;
> +	};
> +
>  	pinctrl_i2c4: i2c4grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C4_SCL__I2C4_SCL	0x4000007f
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
