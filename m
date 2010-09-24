From: hjk@linutronix.de (Hans J. Koch)
Date: Fri, 24 Sep 2010 12:10:06 +0200
Subject: [PATCH v2] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <80aan7sgnj.fsf@merkur.tec.linutronix.de>
References: <80aan7sgnj.fsf@merkur.tec.linutronix.de>
Message-ID: <20100924101006.GB1819@silverbox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 10:13:36AM +0200, John Ogness wrote:
> On 2010-08-13, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> >> In my tests on an mx35pdk board, I found these three clocks being the
> >> minimum set of additional clocks that need to be turned on. That
> >> means, if you turn off any of the three, it won't boot anymore.
> >> 
> >> As a sidenote, it should be clear that this patch is a workaround for
> >> a serious chip bug of the MX35.
> >
> > If you're conviced this is a chip problem, did you consider to contact
> > FSL about it?
> 
> Freescale has responded to my inqueries about the boot ROM issue:
> 
> MX51EVK, MX508ARM2, MX25PDK boards also do this. Freescale has no plans
> to change the MX35 ROM code.

Sad thing. A hardware watchdog is there to protect you in situations where
things go wrong, so it must never assume that certain registers have certain
values.

If a hardware developer chose one of these CPUs for the following reasons

1) he needs internal bootmode to verify the bootloader
2) he needs the hardware watchdog to ensure reliable operation

he can simply not use these SoCs, because there are cases where the boot ROM
will hang until the next hardware reset or powercycle. If he uses such a CPU,
he needs additional hardware for an external watchdog.

Thanks,
Hans
