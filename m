From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 11 Jan 2011 14:52:14 +0100
Subject: Locking in the clk API
In-Reply-To: <20110111121816.GB774@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111101314.GA774@linux-sh.org>
	<201101111830.18597.jeremy.kerr@canonical.com>
	<20110111121816.GB774@linux-sh.org>
Message-ID: <20110111135214.GR24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 09:18:16PM +0900, Paul Mundt wrote:
> On Tue, Jan 11, 2011 at 06:30:18PM +0800, Jeremy Kerr wrote:
> > Hi Paul,
> > 
> > > No, the sleeping clock case is and always will be a corner case, and I
> > > have no interest in pretending otherwise. On SH we have hundreds of
> > > clocks that are all usable in the atomic context and perhaps less than a
> > > dozen that aren't (and even in those cases much of the PLL negotiation is
> > > handled in hardware so there's never any visibility for the lock-down
> > > from the software side, other architectures also have similar behaviour).
> > 
> > I'm not too worried about the corner-cases on the *implementation* side, more 
> > the corner-cases on the API side: are we seeing more users of the API that 
> > require an atomic clock, or more that don't care?
> > 
> Again, you are approaching it from the angle that an atomic clock is a
> special requirement rather than the default behaviour. Sleeping for
particularly if atomic behaviour is the common behaviour it's important
to get it right, because the less common sleeping clocks don't get much
test covering.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
