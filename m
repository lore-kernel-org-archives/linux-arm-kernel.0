From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Wed, 6 Jan 2016 20:39:16 +0200
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160106182650.GM12777@atomide.com>
References: <20160104170206.GC12777@atomide.com> <201601041834.56056@pali>
 <20160104174001.GD12777@atomide.com> <568AC0F9.2010304@gmail.com>
 <20160105041356.GE12777@atomide.com> <20160105084947.GG22661@pali>
 <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com>
Message-ID: <568D5F54.7040900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On  6.01.2016 20:26, Tony Lindgren wrote:

>
> Hmm. Care to verify that your onenand really gets detected at 83 MHz like
> your earlier logs show? Below is a patch that should show it.

before the corruption appeared, I looked a couple of times in syslog and 
the freq there was 83MHz. Including after I disabled CONFIG_OMAP_GPMC_DEBUG.

>
> Also, do things now work reliably for you with CONFIG_OMAP_GPMC_DEBUG
> enabled? Or does that also produce corruption after few reboots?

CONFIG_OMAP_GPMC_DEBUG is disabled, shall I enable it?

> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -153,6 +153,8 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
>   		freq = 0;
>   	}
>
> +	pr_info("onenand rate detected: %i\n", freq);
> +
>   	return freq;
>   }
>

Where am I supposed to get the output from ^^^ if rootfs become 
corrupted? The problem appears after poweroff/restart when it is already 
too late to get the syslog.

BTW, did you compare all the GPMC registers with and without 
HWMOD_INIT_NO_RESET?

Regards,
Ivo
