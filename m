From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 11:12:05 +0200
Subject: [PATCH 1/5] ARM: remove dependency of platform code on
	CLOCK_TICK_RATE / LATCH defines
In-Reply-To: <20101020045121.GX12979@mail.wantstofly.org>
References: <20101020045121.GX12979@mail.wantstofly.org>
Message-ID: <20101020091205.GK28166@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 06:51:21AM +0200, Lennert Buytenhek wrote:
> One of the things preventing building an ARM multiplatform kernel
> image is the fact that CLOCK_TICK_RATE (and as a consequence, LATCH)
> is defined differently for each platform.
> 
> CLOCK_TICK_RATE is mostly unused beyond some usage in the various
> ARM platform support code directories themselves (and a couple of
> bogus uses elsewhere, such as in drivers/input/joystick/analog.c).
> 
> Therefore, for those ARM platforms that use their own definition
> of CLOCK_TICK_RATE (for example, in their timer setup code), copy
> the definition of CLOCK_TICK_RATE into the platform code, renaming
> it to TICK_RATE in the process.
> 
> Also, for those ARM platforms that use the LATCH define (which is
> derived from CLOCK_TICK_RATE), give them a private definition, named
> TIMER_LATCH, based on the now locally defined TICK_RATE.
> 
> This gets rid of platform code dependencies on mach/timex.h's
> CLOCK_TICK_RATE definition, and allows killing all mach/timex.h in
> a subsequent patch.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  arch/arm/common/time-acorn.c         |   15 +++++++++------
>  arch/arm/mach-aaec2000/core.c        |    9 ++++++---
>  arch/arm/mach-at91/at91rm9200_time.c |    8 +++++---
>  arch/arm/mach-at91/at91x40.c         |    3 ++-
ah, this seems to handle the problem I just pointed out for a later
patch in this series.  Maybe you can thread your patches next time?
(E.g. by using git send-email)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
