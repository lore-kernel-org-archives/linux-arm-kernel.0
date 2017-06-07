From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 8 Jun 2017 00:27:11 +0200
Subject: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
In-Reply-To: <20170531225139.30723-5-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
Message-ID: <20170607222711.6kdhuvkymiseootn@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 31, 2017 at 03:51:32PM -0700, Tony Lindgren wrote:
> [...]
> -
>  static inline void omap_init_sti(void) {}
>  
> [...]
> @@ -190,49 +68,8 @@ int __init omap_init_vout(void) { return 0; }
>  
>  static int __init omap2_init_devices(void)
>  {
> -	/* Enable dummy states for those platforms without pinctrl support */
> -	if (!of_have_populated_dt())
> -		pinctrl_provide_dummies();
> -
> -	/* If dtb is there, the devices will be created dynamically */
> -	if (!of_have_populated_dt()) {
> -		/*
> -		 * please keep these calls, and their implementations above,
> -		 * in alphabetical order so they're easier to sort through.
> -		 */
> -		omap_init_mcspi();
> -		omap_init_sham();
> -		omap_init_aes();
> -		omap_init_rng();
> -	}
>  	omap_init_sti();
>  
>  	return 0;
>  }
>  omap_arch_initcall(omap2_init_devices);
> -
> [...]

I guess you can drop omap2_init_devices() completly?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170608/1e42be47/attachment-0001.sig>
