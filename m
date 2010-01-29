From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 29 Jan 2010 15:17:59 -0000
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
In-Reply-To: <20100129145425.GC27577@pengutronix.de>
References: <20100129145425.GC27577@pengutronix.de>
Message-ID: <000101caa0f6$3dfadc50$b9f094f0$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> Sent: 29 January 2010 14:54

> > But as Catalin says, this makes no functional difference, even though
> > it might look "more impressive" :)
>
> With a bigger number of loops_per_seconds the maximal period that can
> be delayed for is shorter and the granularity is better, no?

I concur that this aspect of my comment was technically incorrect - but if
your code was depending on either of those, surely that would be a problem
in itself?

The minimum time would be questionable anyway, as loops_per_second is an
average, and the branch predictor is fairly likely to miss on the first time
through the loop unless your code uses a lot of delays.
 
/
	Leif
