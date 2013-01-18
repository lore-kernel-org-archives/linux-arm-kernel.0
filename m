From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Fri, 18 Jan 2013 14:17:43 +0100
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add GPMC node
In-Reply-To: <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
 <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
Message-ID: <1358515063.3873.31.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-18 at 12:11 +0530, Philip Avinash wrote:
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index eaef5e7..f4209d8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -393,5 +393,17 @@
>  			ti,hwmods = "elm";
>  			status = "disabled";
>  		};
> +
> +		gpmc: gpmc at 50000000 {
> +			compatible = "ti,am3352-gpmc";
> +			ti,hwmods = "gpmc";
> +			reg = <0x50000000 0x2000>;
> +			interrupts = <100>;
> +			num-cs = <8>;

According to the AM335x TRM (SPRUH73G) page 254 we have GPMC_CSn[6:0],
so num-cs should probably be <7>.

> +			num-waitpins = <2>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +		};
>  	};
>  };

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
