From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jun 2012 04:55:11 -0700
Subject: [PATCH 3/3] OMAP4 PANDA register ethernet and wlan for
 automatic mac allocation
In-Reply-To: <20120629055524.11091.57217.stgit@build.warmcat.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <20120629055524.11091.57217.stgit@build.warmcat.com>
Message-ID: <20120629115511.GC4202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andy Green <andy.green@linaro.org> [120628 23:00]:
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -486,6 +486,15 @@ static void omap4_panda_init_rev(void)
>  	}
>  }
>  
> +/*
> + * These device paths represent onboard network devices which have
> + * no MAC address set at boot, and need synthetic ones assigning
> + */
> +static const char * const panda_fixup_mac_device_paths[] = {
> +	"usb1/1-1/1-1.1/1-1.1:1.0",	/* smsc USB <-> Ethernet bridge */
> +	"wl12xx",			/* wlan0 module */
> +};

I suspect the "usb1/1-1/1-1.1/1-1.1:1.0" naming is not valid
if you change the order of loading of musb_hdrc and ehci modules?
Might be worth checking..

Tony
