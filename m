From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Mar 2011 14:00:46 -0700
Subject: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup timer
	and debug counters
In-Reply-To: <1301304157-2466-15-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-15-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110328210046.GE30616@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 02:21]:
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -40,6 +41,11 @@ static int omap4_pm_suspend(void)
>  	int state, ret = 0;
>  	u32 cpu_id = smp_processor_id();
>  
> +	/* Wakeup timer from suspend */
> +	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
> +		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
> +					 wakeup_timer_milliseconds);
> +
>  	/* Save current powerdomain state */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>  		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);

This hack to mess diretly with sys_timer will be ripped out,
so please drop this patch.

In the long run we'll have dmtimer1 dedicated to the PM code,
so then it's possible to do similar things.

Tony
