From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jan 2010 15:54:26 +0100
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
Message-ID: <20100129145425.GC27577@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 29, 2010 at 12:17:18PM -0000, Leif Lindholm wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Dirk Behme
> > Sent: 27 January 2010 16:45
> 
> > On a 400MHz ARM11 MPCore system (NEC NaviEngine based) with kernel
> > 2.6.32 we found that BogoMIPS/loops per jiffies ~doubles (see below
> > [1]) by adding a nop to __delay():
> 
> The reason for this is that the ARM11 MPCore doesn't fold branch
> instructions for busy-wait-style loops. Inserting the nop (or any other
> non-branch instruction) removes the branch instruction from the
> execution stream.
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0360f/ch06s02s04.html
> 
> But as Catalin says, this makes no functional difference, even though it
> might look "more impressive" :)
With a bigger number of loops_per_seconds the maximal period that can be
delayed for is shorter and the granularity is better, no?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
