From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 13:55:03 -0700
Subject: [PATCH] mach-omap2: Remove use of deprecated marco, PTR_RET in
 devices.c
In-Reply-To: <1432150346-31590-1-git-send-email-xerofoify@gmail.com>
References: <1432150346-31590-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150520205503.GN10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicholas Krause <xerofoify@gmail.com> [150520 12:33]:
> This removes the deprecacted marco, PTR_RET and changes the
> functions that use this marco in their return statement to
> instead use the non deprecacted function, PTR_ERR_OR_ZERO
> for the file devices.c.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Applying into omap-for-v4.2/cleanup thanks.

Tony

> ---
>  arch/arm/mach-omap2/devices.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 990338f..a69bd67 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -63,7 +63,7 @@ static int __init omap3_l3_init(void)
>  
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return PTR_RET(pdev);
> +	return PTR_ERR_OR_ZERO(pdev);
>  }
>  omap_postcore_initcall(omap3_l3_init);
>  
> @@ -333,6 +333,6 @@ static int __init omap_gpmc_init(void)
>  	pdev = omap_device_build("omap-gpmc", -1, oh, NULL, 0);
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return PTR_RET(pdev);
> +	return PTR_ERR_OR_ZERO(pdev);
>  }
>  omap_postcore_initcall(omap_gpmc_init);
> -- 
> 2.1.4
> 
