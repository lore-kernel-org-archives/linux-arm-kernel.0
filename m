From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 23 Nov 2017 17:17:12 +0100
Subject: [PATCH 3/3] arm: dts: owl-s500: Add Sparky
In-Reply-To: <003e01d361de$4e1c0710$ea541530$@cem-solutions.net>
References: <20171114180114.26408-1-afaerber@suse.de>
 <20171114180114.26408-4-afaerber@suse.de>
 <003e01d361de$4e1c0710$ea541530$@cem-solutions.net>
Message-ID: <4e2ad665-088e-bf0b-c237-b769b65cb6bc@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Am 20.11.2017 um 10:02 schrieb sudeep kumar:
> Acked-by : sudeep

Thanks. Note it's full name <email>, I can adjust that for you.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-and-cc

What about the preceding two patches? Can Allo/CEM ack them, too?
Without the two bindings patches I can't merge this one.

Regards,
Andreas

> -----Original Message-----
> From: Andreas F?rber [mailto:afaerber at suse.de] 
> Sent: Tuesday, November 14, 2017 11:31 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Thomas Liau <thomas.liau@actions-semi.com>; Jeff Chen <jeff.chen@actions-semi.com>; ??? <zhangdf@actions-semi.com>; ?? <liuwei@actions-semi.com>; ??? <tyzhang@actions-semi.com>; ?? <harrymei@actions-semi.com>; Ioan B <ioan@allo.com>; Sudeep Kumar <sudeepkumar@cem-solutions.net>; linux-kernel at vger.kernel.org; Andreas F?rber <afaerber@suse.de>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Russell King <linux@armlinux.org.uk>; devicetree at vger.kernel.org
> Subject: [PATCH 3/3] arm: dts: owl-s500: Add Sparky
> 
> Add a Device Tree for the Allo.com Sparky SBC.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm/boot/dts/Makefile            |  3 ++-
>  arch/arm/boot/dts/owl-s500-sparky.dts | 44 +++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)  create mode 100644 arch/arm/boot/dts/owl-s500-sparky.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile index d0381e9caf21..ad77f7656a70 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -707,7 +707,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>  	orion5x-rd88f5182-nas.dtb
>  dtb-$(CONFIG_ARCH_ACTIONS) += \
>  	owl-s500-cubieboard6.dtb \
> -	owl-s500-guitar-bb-rev-b.dtb
> +	owl-s500-guitar-bb-rev-b.dtb \
> +	owl-s500-sparky.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>  	prima2-evb.dtb
>  dtb-$(CONFIG_ARCH_OXNAS) += \
> diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
> new file mode 100644
> index 000000000000..f620548c6c0b
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-sparky.dts
> @@ -0,0 +1,44 @@
> +/*
> + * Allo.com Sparky
> + *
> + * Copyright (c) 2017 Andreas F?rber
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)  */
> +
> +/dts-v1/;
> +
> +#include "owl-s500.dtsi"
> +
> +/ {
> +	compatible = "allo,sparky", "actions,s500";
> +	model = "Allo.com Sparky";
> +
> +	aliases {
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>; /* 1 or 2 GiB */
> +	};
> +
> +	uart3_clk: uart3-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <921600>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&timer {
> +	clocks = <&hosc>;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	clocks = <&uart3_clk>;
> +};
> --
> 2.13.6
> 
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
