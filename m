From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 22 Sep 2016 15:58:03 +0200 (CEST)
Subject: [PATCH] clocksource/drivers/ti-32k: Prevent ftrace recursion
In-Reply-To: <20160922075621.3725-1-jszhang@marvell.com>
References: <20160922075621.3725-1-jszhang@marvell.com>
Message-ID: <alpine.DEB.2.20.1609221555590.5599@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2016, Jisheng Zhang wrote:

> Currently ti-32k can be used as a scheduler clock. We properly marked
> omap_32k_read_sched_clock() as notrace but we then call another
> function ti_32k_read_cycles() that _wasn't_ notrace.
> 
> Having a traceable function in the sched_clock() path leads to a
> recursion within ftrace and a kernel crash.

Kernel crash? Doesn't ftrace core prevent recursion?
 
Thanks,

	tglx
