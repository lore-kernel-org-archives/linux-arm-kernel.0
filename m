From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 12 Nov 2010 14:18:12 -0500 (EST)
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <4CDD18F9.5090005@stericsson.com>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
	<20101112095739.GH18358@pengutronix.de>
	<4CDD120A.2050401@stericsson.com>
	<alpine.LFD.2.00.1011121130350.2900@localhost6.localdomain6>
	<4CDD18F9.5090005@stericsson.com>
Message-ID: <alpine.LFD.2.00.1011121416440.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Nov 2010, Linus Walleij wrote:

> Thomas Gleixner wrote:
> > On Fri, 12 Nov 2010, Linus Walleij wrote:
> >> Uwe Kleine-K?nig wrote:
> >>
> >>> Instead of implementing sched_clock for each architecture seperatly,
> >>> wouldn't it be nice to have a generic sched_clock that uses the
> >>> architecture's clocksource?  I tried to implement that some time ago,
> >>> but tglx shoot it down because of locking problems.
> >> I was and still am a big fan of this approach, I am willing to help
> >> testing it if you want to dust off this patch set...
> > 
> > sched_clock is not necessarily the same as the current clocksource.
> 
> IIRC Uwe:s approach was that if and only if you would want to use
> the clocksource for sched_clock() you provide a special flag on
> the clocksource, and it will be attempted to be used for sched_clock().
> 
> Incidentally the dual use of a single free-running timer as both
> single clocksource and sched_clock() baseline seem to creep up in
> a lot of embedded platforms...

Sure, but the computations and associated cost around that free running 
timer are not the same in both cases.


Nicolas
