From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sat, 23 Apr 2011 14:33:01 -0700
Subject: [patch 01/16] time: Provide clocksource based sched_clock()
In-Reply-To: <20110423205131.574884925@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.574884925@linutronix.de>
Message-ID: <4DB3458D.6000806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2011 1:54 PM, Thomas Gleixner wrote:
> Index: linux-2.6-tip/kernel/time/Kconfig
> ===================================================================
> --- linux-2.6-tip.orig/kernel/time/Kconfig
> +++ linux-2.6-tip/kernel/time/Kconfig
> @@ -27,3 +27,7 @@ config GENERIC_CLOCKEVENTS_BUILD
>  	default y
>  	depends on GENERIC_CLOCKEVENTS || GENERIC_CLOCKEVENTS_MIGR
> 
> +# Selectable by architectures which want to reuse the clocksource as
> +# sched_clock
> +config HAVE_CLKSRC_SCHED_CLOCK
> +       bool
