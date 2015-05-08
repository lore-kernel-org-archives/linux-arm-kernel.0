From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 08 May 2015 10:44:59 +0200
Subject: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
In-Reply-To: <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
Message-ID: <1431074699.13593.4.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig

> +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> +	bool
> +	depends on CLKSRC_ST_LPC
> +	default y
> +	help
> +	  Use Low Power controller timer clock source as sched_clock

This adds, as far as I can see, a Kconfig symbol that will always be in
lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be 'y'.

Are there plans to break that lockstep in the future?

Thanks,


Paul Bolle
