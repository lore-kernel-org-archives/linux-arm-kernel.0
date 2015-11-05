From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 05 Nov 2015 12:00:35 +0100
Subject: [PATCH 1/4] ARM: dts: kirkwood: add Linksys EA4500
In-Reply-To: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
References: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
Message-ID: <op.x7mji9qy2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Nov 2015 23:25:05 +0100, Luka Perkov <luka.perkov@sartura.hr>  
wrote:

<snip>

> --- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> @@ -49,6 +49,7 @@ board. Currently known boards are:
>  "lacie,netspace_max_v2"
>  "lacie,netspace_mini_v2"
>  "lacie,netspace_v2"
> +"linksys,ea4500"
>  "marvell,db-88f6281-bp"
>  "marvell,db-88f6282-bp"
>  "marvell,mv88f6281gtw-ge"

The same device was sold as the ea4200v2 as well. Please use the  
engineering name "viper" instead, as discussed at  
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319590.html

> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -124,6 +124,7 @@ lantiq	Lantiq Semiconductor
>  lenovo	Lenovo Group Ltd.
>  lg	LG Corporation
>  linux	Linux-specific binding
> +linksys	Belkin International, Inc.
>  lsi	LSI Corp. (LSI Logic)
>  lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.

Although Linksys is a subsidiary of Belkin, I think linksys should stay  
Linksys here ;)

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bb8fa02..a16c04b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -168,6 +168,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-ds411.dtb \
>  	kirkwood-ds411j.dtb \
>  	kirkwood-ds411slim.dtb \
> +	kirkwood-ea4500.dtb \
>  	kirkwood-goflexnet.dtb \
>  	kirkwood-guruplug-server-plus.dtb \
>  	kirkwood-ib62x0.dtb \

"kirkwood-viper.dtb"

> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-ea4500.dts
> @@ -0,0 +1,156 @@

<snip>

> +	model = "Linksys EA4500";
> +	compatible = "linksys,ea4500", "marvell,kirkwood-88f6282",  
> "marvell,kirkwood";

model = "Linksys EA4200v2 / EA4500"
compatible = "linksys,viper", "marvell,kirkwood-88f6282",  
"marvell,kirkwood";

<snip>

> +&nand {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_nand>;
> +	pinctrl-names = "default";
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x80000>;
> +	};
> +
> +	partition at 80000 {
> +		label = "u-boot environment";
> +		reg = <0x80000 0x20000>;
> +	};
> +
> +	partition at 200000 {
> +		label = "kernel";
> +		reg = <0x200000 0x200000>;
> +	};
> +
> +	partition at 400000 {
> +		label = "root";
> +		reg = <0x400000 0x1c00000>;
> +	};
> +};

Please use the factory partitions instead.


Imre
