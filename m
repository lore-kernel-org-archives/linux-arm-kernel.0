From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 May 2013 11:47:28 -0700
Subject: [PATCH v2 2/5] ARM: dts: OMAP2+: use existing constants for GPIOs
In-Reply-To: <1369323421-4180-3-git-send-email-florian.vaussard@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
 <1369323421-4180-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130523184727.GF13507@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130523 08:42]:
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -29,13 +29,13 @@
>  
>  		heartbeat {
>  			label = "beagleboard::usr0";
> -			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
> +			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* 150 -> D6 LED */
>  			linux,default-trigger = "heartbeat";
>  		};
>  
>  		mmc {
>  			label = "beagleboard::usr1";
> -			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
> +			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>; /* 149 -> D7 LED */
>  			linux,default-trigger = "mmc0";
>  		};
>  	};

Great yeah this is the way to go instead of the fixed numbering.
Thanks for doing this.

Regards,

Tony
