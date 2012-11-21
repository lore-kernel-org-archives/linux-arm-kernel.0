From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Nov 2012 10:23:42 -0800
Subject: [PATCH v3 1/2] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <1353395835-17390-1-git-send-email-grinberg@compulab.co.il>
References: <1353251201-10990-2-git-send-email-grinberg@compulab.co.il>
 <1353395835-17390-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20121121182342.GX18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [121119 23:19]:
> CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
> Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
> setting.
> To remove the dependancy, several conversions/additions had to be done:
> 1) Timer initialization functions are named by the platform
>    name and the clock source in use.
>    This also makes it possible to define and use the GPTIMER as the
>    clock source instead of the 32K timer on platforms that do not have
>    the 32K timer ip block or the 32K timer is not wired on the board.
>    Currently, the the timer is chosen in the machine_desc structure on
>    per board basis. Later, DT should be used to choose the timer.
> 2) Settings under the CONFIG_OMAP_32K_TIMER option are used as defaults
>    and those under !CONFIG_OMAP_32K_TIMER are removed.
>    This removes the CONFIG_OMAP_32K_TIMER on OMAP2+ timer code.
> 3) Since we have all the timers defined inside machine_desc structure
>    and we no longer need the fallback to gp_timer clock source in case
>    32k_timer clock source is unavailable (namely on AM33xx), we no
>    longer need the #ifdef around omap2_sync32k_clocksource_init()
>    function. Remove the #ifdef CONFIG_OMAP_32K_TIMER around the
>    omap2_sync32k_clocksource_init() function.

Thanks for cleaning this up. Applying both into omap-for-v3.8/timer.

Regards,

Tony
