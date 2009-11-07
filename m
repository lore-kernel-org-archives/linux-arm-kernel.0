From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 7 Nov 2009 23:05:00 +0100
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <1257510130.13580.38.camel@pc1117.cambridge.arm.com>
References: <20091105181501.GA7221@pengutronix.de>
	<1257510130.13580.38.camel@pc1117.cambridge.arm.com>
Message-ID: <20091107220500.GA4683@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 06, 2009 at 12:22:10PM +0000, Catalin Marinas wrote:
> On Thu, 2009-11-05 at 18:15 +0000, Uwe Kleine-K?nig wrote:
> > On Thu, Nov 05, 2009 at 12:35:12PM +0000, Catalin Marinas wrote:
> > > diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> > > new file mode 100644
> > > index 0000000..85aa2b2
> > > --- /dev/null
> > > +++ b/arch/arm/kernel/early_printk.c
> > > @@ -0,0 +1,57 @@
> > > +/*
> > > + *  linux/arch/arm/kernel/early_printk.c
> > > + *
> > > + *  Copyright (C) 2009 Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > <nitpick>
> > remove one space before "linux" and "Copyright"
> > </nitpick>
> 
> That's how many other files with Russell's copyright were written (e.g.
> drivers/serial/serial_core.c, mmu.c etc.), so we just follow the
> tradition :-).
OK, will check and send a few patches :-) Honestly, I don't care much.
Wouldn't have bothered without my comment below.

> > > +static void early_write(const char *s, unsigned n)
> > > +{
> > > +     while (n-- > 0) {
> > > +             if (*s == '\n')
> > > +                     printch('\r');
> > > +             printch(*s);
> > > +             s++;
> > > +     }
> > > +}
> > 
> > Can you better use uart_console_write here?  (If yes, don't forget to
> > select CONFIG_SERIAL_CORE.)
> 
> This early console should work with ICE DCC as well, so adding the
> uart_* calls may be a bit confusing (plus one more indirection of calls
> to drop the first argument passed to printch by uart_console_write).
My comment was a question on purpose.  If you don't like it it's OK for
me, too.

>                                                                      The
> x86 variant doesn't do this either.
You have no ambition to be better than x86? :-)

Anyhow:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards and thanks for picking that patch up
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
