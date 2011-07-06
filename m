From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 14:05:43 +0200
Subject: [PATCH V2 2/6] arm_smp_twd: mpcore_wdt: Fix watchdog counter
	loading
In-Reply-To: <1309892440-3260-3-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-3-git-send-email-vkuzmichev@mvista.com>
Message-ID: <201107061405.44096.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Vitaly Kuzmichev wrote:
> +/* Needed by mpcore_wdt */
> +unsigned long twd_timer_get_rate(void)
> +{
> +       unsigned long rate;
> +
> +       if (!IS_ERR_OR_NULL(twd_clk))
> +               rate = clk_get_rate(twd_clk);
> +       else
> +               rate = twd_timer_rate;
> +       return rate;
> +}
> +EXPORT_SYMBOL(twd_timer_get_rate);

I would generally prefer to make new exported symbols EXPORT_SYMBOL_GPL
instead of EXPORT_SYMBOL.

	Arnd
