From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Mon, 21 Dec 2009 15:59:28 +0100
Subject: [PATCH 1/2] imx/mx3: fix FTBFS for undefined symbols mx31_usbh1
	and mx31_usbh2
In-Reply-To: <1261253921-29125-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1261253921-29125-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4B2F8D50.60902@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Uwe,

Uwe Kleine-K?nig wrote:
> Use the symbols mxc_usbh1 and mxc_usbh2 introduced in
> 
> 	c13a482 (MX3: Add USB platform devices and resources)
> 
> instead.

I have sent a patch to fix this. It was first sent on December, 4th and 
again on December, 18th 
(http://article.gmane.org/gmane.linux.ports.arm.kernel/71126)

I hope it will be picked for next -rc.

Best Regards

Val

> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
> Cc: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/mach-mx3/mach-mx31moboard.c     |    2 +-
>  arch/arm/mach-mx3/mx31moboard-devboard.c |    2 +-
>  arch/arm/mach-mx3/mx31moboard-marxbot.c  |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
> index be7d277..949b4de 100644
> --- a/arch/arm/mach-mx3/mach-mx31moboard.c
> +++ b/arch/arm/mach-mx3/mach-mx31moboard.c
> @@ -392,7 +392,7 @@ static int __init moboard_usbh2_init(void)
>  	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
>  			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
>  
> -	return mxc_register_device(&mx31_usbh2, &usbh2_pdata);
> +	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
>  }
>  
>  
> diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
> index 8fc624f..438428e 100644
> --- a/arch/arm/mach-mx3/mx31moboard-devboard.c
> +++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
> @@ -179,7 +179,7 @@ static int __init devboard_usbh1_init(void)
>  
>  	usbh1_pdata.otg = otg;
>  
> -	return mxc_register_device(&mx31_usbh1, &usbh1_pdata);
> +	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
>  }
>  
>  /*
> diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> index 85184a3..1f44b9c 100644
> --- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
> +++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> @@ -294,7 +294,7 @@ static int __init marxbot_usbh1_init(void)
>  
>  	usbh1_pdata.otg = otg;
>  
> -	return mxc_register_device(&mx31_usbh1, &usbh1_pdata);
> +	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
>  }
>  
>  /*


-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
