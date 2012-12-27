From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 27 Dec 2012 12:05:24 -0500
Subject: [PATCH] ARM: Kirkwood: Bundle the common pinctrl of 88f6281
 and 88f6282
In-Reply-To: <1356230149-15437-1-git-send-email-iwamatsu@nigauri.org>
References: <1356230149-15437-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <20121227170524.GX21694@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 11:35:49AM +0900, Nobuhiro Iwamatsu wrote:
> 88f6281 and 88f6282 has common pinctrl.
> This buldles the common pincrtl of these to kirkwood-628x-base.dtsi.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/arm/boot/dts/kirkwood-6281.dtsi      |   38 ++------------------------
>  arch/arm/boot/dts/kirkwood-6282.dtsi      |   35 ++----------------------
>  arch/arm/boot/dts/kirkwood-628x-base.dtsi |   41 +++++++++++++++++++++++++++++

Is there a reason we can't move the contents of the proposed
kirkwood-628x-base.dtsi into kirkwood.dtsi ?

Also, please don't forget to CC Andrew Lunn and myself for kirkwood
patches.  I've added him.

thx,

Jason.

>  3 files changed, 45 insertions(+), 69 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-628x-base.dtsi
> 
> diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
> index d6c9d65..c8fe885 100644
> --- a/arch/arm/boot/dts/kirkwood-6281.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
> @@ -1,44 +1,10 @@
> +/include/ "kirkwood-628x-base.dtsi"
> +
>  / {
>  	ocp at f1000000 {
>  		pinctrl: pinctrl at 10000 {
>  			compatible = "marvell,88f6281-pinctrl";
>  			reg = <0x10000 0x20>;
> -
> -			pmx_nand: pmx-nand {
> -				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> -					       "mpp4", "mpp5", "mpp18",
> -					       "mpp19";
> -				marvell,function = "nand";
> -			};
> -			pmx_sata0: pmx-sata0 {
> -				marvell,pins = "mpp5", "mpp21", "mpp23";
> -				marvell,function = "sata0";
> -			};
> -			pmx_sata1: pmx-sata1 {
> -				marvell,pins = "mpp4", "mpp20", "mpp22";
> -				marvell,function = "sata1";
> -			};
> -			pmx_spi: pmx-spi {
> -				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
> -				marvell,function = "spi";
> -			};
> -			pmx_twsi0: pmx-twsi0 {
> -				marvell,pins = "mpp8", "mpp9";
> -				marvell,function = "twsi0";
> -			};
> -			pmx_uart0: pmx-uart0 {
> -				marvell,pins = "mpp10", "mpp11";
> -				marvell,function = "uart0";
> -			};
> -			pmx_uart1: pmx-uart1 {
> -				marvell,pins = "mpp13", "mpp14";
> -				marvell,function = "uart1";
> -			};
> -			pmx_sdio: pmx-sdio {
> -				marvell,pins = "mpp12", "mpp13", "mpp14",
> -					       "mpp15", "mpp16", "mpp17";
> -				marvell,function = "sdio";
> -			};
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
> index e0a779c..7ce9614 100644
> --- a/arch/arm/boot/dts/kirkwood-6282.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
> @@ -1,3 +1,5 @@
> +/include/ "kirkwood-628x-base.dtsi"
> +
>  / {
>  	ocp at f1000000 {
>  
> @@ -5,43 +7,10 @@
>  			compatible = "marvell,88f6282-pinctrl";
>  			reg = <0x10000 0x20>;
>  
> -			pmx_nand: pmx-nand {
> -				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> -							"mpp4", "mpp5", "mpp18", "mpp19";
> -				marvell,function = "nand";
> -			};
> -
> -			pmx_sata0: pmx-sata0 {
> -				marvell,pins = "mpp5", "mpp21", "mpp23";
> -				marvell,function = "sata0";
> -			};
> -			pmx_sata1: pmx-sata1 {
> -				marvell,pins = "mpp4", "mpp20", "mpp22";
> -				marvell,function = "sata1";
> -			};
> -			pmx_spi: pmx-spi {
> -				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
> -				marvell,function = "spi";
> -			};
> -			pmx_twsi0: pmx-twsi0 {
> -				marvell,pins = "mpp8", "mpp9";
> -				marvell,function = "twsi0";
> -			};
> -
>  			pmx_twsi1: pmx-twsi1 {
>  				marvell,pins = "mpp36", "mpp37";
>  				marvell,function = "twsi1";
>  			};
> -
> -			pmx_uart0: pmx-uart0 {
> -				marvell,pins = "mpp10", "mpp11";
> -				marvell,function = "uart0";
> -			};
> -
> -			pmx_uart1: pmx-uart1 {
> -				marvell,pins = "mpp13", "mpp14";
> -				marvell,function = "uart1";
> -			};
>  		};
>  
>  		i2c at 11100 {
> diff --git a/arch/arm/boot/dts/kirkwood-628x-base.dtsi b/arch/arm/boot/dts/kirkwood-628x-base.dtsi
> new file mode 100644
> index 0000000..c8103b6
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-628x-base.dtsi
> @@ -0,0 +1,41 @@
> +/ {
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pmx_nand: pmx-nand {
> +				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> +					       "mpp4", "mpp5", "mpp18",
> +					       "mpp19";
> +				marvell,function = "nand";
> +			};
> +			pmx_sata0: pmx-sata0 {
> +				marvell,pins = "mpp5", "mpp21", "mpp23";
> +				marvell,function = "sata0";
> +			};
> +			pmx_sata1: pmx-sata1 {
> +				marvell,pins = "mpp4", "mpp20", "mpp22";
> +				marvell,function = "sata1";
> +			};
> +			pmx_spi: pmx-spi {
> +				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
> +				marvell,function = "spi";
> +			};
> +			pmx_twsi0: pmx-twsi0 {
> +				marvell,pins = "mpp8", "mpp9";
> +				marvell,function = "twsi0";
> +			};
> +			pmx_uart0: pmx-uart0 {
> +				marvell,pins = "mpp10", "mpp11";
> +				marvell,function = "uart0";
> +			};
> +			pmx_uart1: pmx-uart1 {
> +				marvell,pins = "mpp13", "mpp14";
> +				marvell,function = "uart1";
> +			};
> +			pmx_sdio: pmx-sdio {
> +				marvell,pins = "mpp12", "mpp13", "mpp14",
> +					       "mpp15", "mpp16", "mpp17";
> +				marvell,function = "sdio";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
