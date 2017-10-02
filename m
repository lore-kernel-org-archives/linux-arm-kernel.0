From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Oct 2017 18:24:05 +0200
Subject: [PATCH 5/7] ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818
 regulator nodes
In-Reply-To: <20170929032514.31727-6-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
 <20170929032514.31727-6-wens@csie.org>
Message-ID: <20171002162405.jndvig3fxuj6d3ce@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 29, 2017 at 03:25:12AM +0000, Chen-Yu Tsai wrote:
> +#include "axp81x.dtsi"
> +
> +&reg_aldo1 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-name = "vcc18-csi2-dsi-efuse-hdmi-d4dp";
> +};

I'm not really fond of these names. It's easy to miss some components
(especially since we most of the time don't have the schematics), and
if it's not complete, the obscure name isn't worth it either.

What about vcc-1.8 for this one ?

> +&reg_aldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-name = "vdd-drampll-vcc18-pll-adc-cpvdd-ldoin";
> +};

dram-pll?

> +&reg_aldo3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "vcc-pl-avcc";
> +};

avcc?

etc..

>  	status = "disabled";
>  };
>  
> +&reg_vcc3v3 {
> +	status = "disabled";
> +};
> +
>  &reg_vcc5v0 {
>  	status = "disabled";
>  };

Why not simply remove the DTSI then?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/290c9d6e/attachment.sig>
