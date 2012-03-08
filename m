From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 12:46:07 -0800
Subject: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
In-Reply-To: <20120308204328.GW12083@atomide.com>
References: <20120308204328.GW12083@atomide.com>
Message-ID: <20120308204607.GX12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120308 12:11]:
> Otherwise we will get:
> 
> arch/arm/plat-omap/fb.c:101: error: expected ?)? before ?*? token
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Tomi, you need something like this for what you have in for-next.
> 
> --- a/arch/arm/plat-omap/fb.c
> +++ b/arch/arm/plat-omap/fb.c
> @@ -98,6 +98,8 @@ arch_initcall(omap_init_fb);
>  
>  #else
>  
> -void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
> +void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
> +{
> +}
>  
>  #endif

Also now seeing the following with what you have in for-next:

drivers/video/omap2/displays/panel-taal.c: In function ?taal_num_errors_show?:
drivers/video/omap2/displays/panel-taal.c:605: warning: ?errors? may be used uninitialized in this function

Tony
