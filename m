From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 10:43:03 -0700
Subject: [PATCH] mach-omap2:Remove calls to deprecacted marco,PTR_RET in
 the files,fb.c and pmu.c
In-Reply-To: <1431233854-31982-1-git-send-email-xerofoify@gmail.com>
References: <1431233854-31982-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150520174302.GB10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicholas Krause <xerofoify@gmail.com> [150509 21:58]:
> This removes two calls to the deprecated marco,PTR_RET in
> the files,fb.c and pmu.c for the functions,omap_init_vrfb
> and omap_init_pmu respectfully. Furthermore these are now
> replaced by calling the correctly non deprecacted function,
> PTR_ERR_OR_ZERO in both functions.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Applying into omap-for-v4.2/cleanup thanks.

Tony

> ---
>  arch/arm/mach-omap2/fb.c  | 2 +-
>  arch/arm/mach-omap2/pmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
> index 26e28e9..1f1ecf8 100644
> --- a/arch/arm/mach-omap2/fb.c
> +++ b/arch/arm/mach-omap2/fb.c
> @@ -84,7 +84,7 @@ int __init omap_init_vrfb(void)
>  	pdev = platform_device_register_resndata(NULL, "omapvrfb", -1,
>  			res, num_res, NULL, 0);
>  
> -	return PTR_RET(pdev);
> +	return PTR_ERR_OR_ZERO(pdev);
>  }
>  #else
>  int __init omap_init_vrfb(void) { return 0; }
> diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
> index a69e9a3..d2adfeb 100644
> --- a/arch/arm/mach-omap2/pmu.c
> +++ b/arch/arm/mach-omap2/pmu.c
> @@ -55,7 +55,7 @@ static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
>  	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
>  	     dev_name);
>  
> -	return PTR_RET(omap_pmu_dev);
> +	return PTR_ERR_OR_ZERO(omap_pmu_dev);
>  }
>  
>  static int __init omap_init_pmu(void)
> -- 
> 2.1.4
> 
