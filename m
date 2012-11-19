From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 11:44:43 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Convert mplcec4 board to pinctrl
In-Reply-To: <6179db81ec8e8760511f776f460e9ed408a95390.1353319919.git.s.peter@mpl.ch>
References: <cover.1353319919.git.s.peter@mpl.ch>
 <6179db81ec8e8760511f776f460e9ed408a95390.1353319919.git.s.peter@mpl.ch>
Message-ID: <20121119104443.GG10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:26:45AM +0100, Stefan Peter wrote:
> 
> Signed-off-by: Stefan Peter <s.peter@mpl.ch>
> ---
> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> index ac3c080..e692e90 100644
> --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> @@ -1,6 +1,7 @@
>  /dts-v1/;
>  
>  /include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6281.dtsi"
>  
>  / {
>  	model = "MPL CEC4";
> @@ -16,6 +17,69 @@
>          };
>  
>  	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +
> +			pinctrl-0 = < &pmx_nand &pmx_uart0
> +				      &pmx_led_health &pmx_sdio
> +				      &pmx_sata0 &pmx_sata1
> +				      &pmx_led_user1o
> +				      &pmx_led_user1g &pmx_led_user0o
> +				      &pmx_led_user0g &pmx_led_misc
> +				      &pmx_sdio_cd
> +				    >;
> +			pinctrl-names = "default";
> +
> +			pmx_led_health: pmx-led-health {
> +				marvell,pins = "mpp7";
> +				marvell,function = "gpo";
> +			};
> +
> +			pmx_sdio: pmx-sdio {
> +				marvell,pins = "mpp12", "mmp13", "mpp14",
> +					       "mpp15", "mpp16", "mpp17";
> +				marvell,function = "sdio";
> +			};

Please could you move this into kirkwood-6281.dtsi. It should be
generic so that other boards using sdio can use it.

	Thanks
		Andrew
