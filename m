From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 05 Dec 2013 16:20:06 +0400
Subject: [PATCH] ARM: shmobile: Genmai SPI over GPIO support
In-Reply-To: <20131204212915.24243.27225.sendpatchset@w520>
References: <20131204212915.24243.27225.sendpatchset@w520>
Message-ID: <52A06F76.1010105@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-12-2013 1:29, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>

> Hook up the serial flash memory to bit bang SPI on the Genmai board.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

>   Written on to of renesas git tag renesas-devel-v3.13-rc2-20131202 and
>   [PATCH 00/04] ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL support

>   arch/arm/boot/dts/r7s72100-genmai-reference.dts |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)

> --- 0010/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-12-05 06:23:57.000000000 +0900
> @@ -56,5 +56,20 @@
>   			reg = <0x50>;
>   		};
>   	};
> +	spi0 {

    Maybe just "spi"?

> +		compatible = "spi-gpio";
> +		gpio-sck = <&port9 2 0>;
> +		gpio-mosi = <&port9 4 0>;
> +		gpio-miso = <&port9 5 0>;
> +		cs-gpios = <&port9 3 0>;
> +		num-chipselects = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>
> +		s25fl512s: s25fl512s0 {

    The node should probably be named "flash", according to ePAPR spec. And 
why you didn't specify "@0"?

> +			compatible = "s25fl512s";
> +			reg = <0>;
> +			spi-max-frequency = <104000000>;
> +                };
> +        };
>   };

WBR, Sergei
