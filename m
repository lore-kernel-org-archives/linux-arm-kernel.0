From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 08 Dec 2013 11:45:32 +0100
Subject: [PATCH v2] rtc: pxa: drop unused #define TIMER_FREQ
In-Reply-To: <1386455449-19678-1-git-send-email-u.kleine-koenig@pengutronix.de>
 ("Uwe \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Sat, 7 Dec 2013
 23:30:49 +0100")
References: <87mwkc77d8.fsf@free.fr>
 <1386455449-19678-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <87iouz7h9v.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> It seems this symbol was unused since the driver was introduced in
> commit dc94436 (rtc: driver for pxa27x and pxa3xx SoC) back in 2009.
>
> As a by-product this patch makes the driver stop "using" the symbol
> CLOCK_TICK_RATE which is about to be removed very soon (for ARM).
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1, sent with
> Message-id:1383942318-12569-1-git-send-email-u.kleine-koenig at pengutronix.de:
>
>  - drop define instead of s/CLOCK_TICK_RATE/get_clock_tick_rate()/; thanks to
>    Robert Jarzmik for pointing that out.
>
> Note I intend to send this patch as part of a series that removes
> <mach/timex.h> (and so CLOCK_TICK_RATE) on ARM. So dear maintainer please don't
> take this patch but give your blessing that I can take it. (Note, I'm not sure
> who's ack I need here; according to MAINTAINERS Alessandro Zummo maintains the
> rtc subsystem, but he doesn't seem to be that active for some time and it's
> mostly akpm who takes patches.)

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

And you're right, Andrew took the last patches to RTC.

Cheers.

--
Robert
