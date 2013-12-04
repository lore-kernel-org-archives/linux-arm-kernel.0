From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Dec 2013 23:54:15 +0100
Subject: [PATCH] ARM: shmobile: Genmai SPI over GPIO support
In-Reply-To: <20131204212915.24243.27225.sendpatchset@w520>
References: <20131204212915.24243.27225.sendpatchset@w520>
Message-ID: <3565394.fetym5DAi6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Thursday 05 December 2013 06:29:15 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook up the serial flash memory to bit bang SPI on the Genmai board.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written on to of renesas git tag renesas-devel-v3.13-rc2-20131202 and
>  [PATCH 00/04] ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL support
> 
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> --- 0010/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-12-05
> 06:23:57.000000000 +0900 @@ -56,5 +56,20 @@
>  			reg = <0x50>;
>  		};
>  	};
> +	spi0 {
> +		compatible = "spi-gpio";
> +		gpio-sck = <&port9 2 0>;
> +		gpio-mosi = <&port9 4 0>;
> +		gpio-miso = <&port9 5 0>;
> +		cs-gpios = <&port9 3 0>;

What about replacing those 0 with GPIO_ACTIVE_HIGH ?

> +		num-chipselects = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> 
> +		s25fl512s: s25fl512s0 {

The node should be called flash at 0.

> +			compatible = "s25fl512s";
> +			reg = <0>;
> +			spi-max-frequency = <104000000>;
> +                };
> +        };

Please use tabs for indentation here.

The rest looks fine to me, but I obviously can't review most of the 
information as I don't have access to the board schematics. I'll trust you 
that you have tested the patch :-)

>  };
-- 
Regards,

Laurent Pinchart
