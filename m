From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jun 2015 00:22:39 +0200
Subject: [PATCH 2/2] ARM: dts: add buffalo linkstation ls-wvl/vl
In-Reply-To: <1434713319-8691-3-git-send-email-rogershimizu@gmail.com>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-3-git-send-email-rogershimizu@gmail.com>
Message-ID: <20150619222239.GB1116@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> @@ -23,6 +23,7 @@ board. Currently known boards are:
>  "buffalo,lsxhl"
>  "buffalo,lsxl"
>  "buffalo,lswxl"
> +"buffalo,lswvl"
>  "dlink,dns-320"
>  "dlink,dns-320-a1"
>  "dlink,dns-325"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e0ebd59..a16cfca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -178,6 +178,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-lschlv2.dtb \
>  	kirkwood-lsxhl.dtb \
>  	kirkwood-lswxl.dtb \
> +	kirkwood-lswvl.dtb \
>  	kirkwood-mplcec4.dtb \
>  	kirkwood-mv88f6281gtw-ge.dtb \
>  	kirkwood-nas2big.dtb \

We try to keep these in alphabetical order. So lswvl.dtb should be
before lswxl.dtb in both these lists.

> +		i2c at 11000 {
> +			status = "okay";
> +		};

Is there something on the i2c bus?

> +
> +		serial at 12000 {
> +			pinctrl-0 = <&pmx_uart0>;
> +			pinctrl-names = "default";

You don't need the pinctrl properties. 

> +			status = "okay";
> +		};
> +

Thanks
	Andrew
