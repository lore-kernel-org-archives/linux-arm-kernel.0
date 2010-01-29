From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 15:26:17 +0000
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
In-Reply-To: <000101caa0f6$3dfadc50$b9f094f0$@lindholm@arm.com>
References: <20100129145425.GC27577@pengutronix.de>
	<000101caa0f6$3dfadc50$b9f094f0$@lindholm@arm.com>
Message-ID: <20100129152617.GB17299@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 03:17:59PM -0000, Leif Lindholm wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> > Sent: 29 January 2010 14:54
> 
> > > But as Catalin says, this makes no functional difference, even though
> > > it might look "more impressive" :)
> >
> > With a bigger number of loops_per_seconds the maximal period that can
> > be delayed for is shorter and the granularity is better, no?
> 
> I concur that this aspect of my comment was technically incorrect - but if
> your code was depending on either of those, surely that would be a problem
> in itself?
> 
> The minimum time would be questionable anyway, as loops_per_second is an
> average, and the branch predictor is fairly likely to miss on the first time
> through the loop unless your code uses a lot of delays.

Not only that, but it takes a certain number of cycles to calculate the
number of loops for any given delay; the smaller the delay the more
significant that is.  For very short delays (eg, one loop) that it
swamps the loop itself.
