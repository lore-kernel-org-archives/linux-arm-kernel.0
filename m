From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Aug 2012 11:21:45 +0200
Subject: restart callback not supposed to sleep?
In-Reply-To: <20120820090546.GR18957@n2100.arm.linux.org.uk>
References: <20120820082423.GJ2232@pengutronix.de>
 <20529.64510.403690.325993@ipc1.ka-ro>
 <20120820090546.GR18957@n2100.arm.linux.org.uk>
Message-ID: <20120820092145.GM2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 10:05:46AM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 20, 2012 at 10:57:34AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Uwe Kleine-K?nig writes:
> > > Hello,
> > > 
> > > while triggering a reboot via sysrq on an ARM machine I saw a "BUG:
> > > sleeping function called from invalid context" message (details below).
> > > The reason is that the sysrq handler is calling the restart hook in irq
> > > context. So what should be done about that? The obvious possiblities
> > > are:
> > > 
> > >  a) ignore the problem as it won't result in problems (and maybe somehow
> > >     silence the warnign); or
> > >  b) make the restart hook atomic; or
> > >  c) assert sysrq not calling the hook in atomic mode
> > > 
> > > What do you think?
> > > 
> > This has been discussed earlier (with your participation) with 'a)'
> > being the conclusion.
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/033877.html
> 
> Except if you look at the backtrace, it seems that it fails to restart.
> There are two attempts there at making it restart so the first could
> not have succeeded.
Just for the log: The restart works ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
