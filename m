From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Mar 2013 09:30:43 -0700
Subject: [PATCH] ARM: OMAP: fix typo "CONFIG_SMC91x_MODULE"
In-Reply-To: <1362744397.5994.58.camel@x61.thuisdomein>
References: <1362744397.5994.58.camel@x61.thuisdomein>
Message-ID: <20130320163043.GM16413@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [130308 04:10]:
> There's a (rather subtle) typo in "CONFIG_SMC91x_MODULE". Fix it once
> and for all by using IS_ENABLED(), which is designed to avoid issues
> like this.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested! And this needs build- and runtime testing, especially for the
> MODULE case!

Thanks looks good to me. Since this is for legacy platforms and been
broken for quite a while, I'll apply it into omap-for-v3.10/fixes-non-critical.

Regards,

Tony
 
>  arch/arm/mach-omap2/board-2430sdp.c | 2 +-
>  arch/arm/mach-omap2/board-h4.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index a3e0aaa..cb0596b 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -166,7 +166,7 @@ static void __init sdp2430_display_init(void)
>  	omap_display_init(&sdp2430_dss_data);
>  }
>  
> -#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
> +#if IS_ENABLED(CONFIG_SMC91X)
>  
>  static struct omap_smc91x_platform_data board_smc91x_data = {
>  	.cs		= 5,
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
> index 812c829..5b4ec51 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -246,7 +246,7 @@ static u32 is_gpmc_muxed(void)
>  		return 0;
>  }
>  
> -#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
> +#if IS_ENABLED(CONFIG_SMC91X)
>  
>  static struct omap_smc91x_platform_data board_smc91x_data = {
>  	.cs		= 1,
> -- 
> 1.7.11.7
> 
