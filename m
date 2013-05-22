From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 May 2013 09:28:51 -0600
Subject: [PATCH 3/5] ARM: dts: OMAP2+: convert DT files to use the new
 OMAP_GPIO macro
In-Reply-To: <1369232864-14460-4-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-4-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <519CE433.10903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 08:27 AM, Florian Vaussard wrote:
> Use OMAP_GPIO(), in conjunction with standard GPIO flags, to enhance the
> readability of DT GPIOs.

> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index e0ce823..e773a5e 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -29,13 +29,13 @@
>  
>  		heartbeat {
>  			label = "beagleboard::usr0";
> -			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
> +			gpios = OMAP_GPIO(150, GPIO_ACTIVE_HIGH); /* 150 -> D6 LED */

One of the advantages of cpp support for me is the ability to remove the
redundant part of the command. In other words, perhaps remove the "150
->" since that information is part of the OMAP_GPIO() "call", leaving
just /* D6 LED */. I might have expected "D6" to be the label too, thus
removing any need for the comment.
