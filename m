From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 17 Nov 2011 09:42:00 +0000
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <20111117092946.GA2535@pengutronix.de>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
 <20111116132222.GD2596@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722D4E65@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111116135125.GE2596@pengutronix.de>
 <20111117011833.GD14656@S2100-06.ap.freescale.net>
 <20111117092946.GA2535@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E3B2F@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Thursday, November 17, 2011 5:30 PM
> To: Guo Shawn-R65073
> Cc: Dong Aisheng-B29396; linux-arm-kernel at lists.infradead.org; Sascha
> Hauer; Guo Shawn-R65073
> Subject: Re: [PATCH] arm: mx28: check for gated clocks when setting saif
> divider
> 
> > > I chose this approach because this is the common pattern in all
> > > other clocks. There might be a better way of handling this, but then
> > > we'd need to adapt all other clocks as well. What we definately
> > > should not have is one kind of handling the 'already enabled' case
> > > for a few clocks and another kind for others.
> > >
> > What about leaving it as it is for now, and try to consolidate when we
> > rework the code for common clock framework migration?
> 
> In general, very fine with me. I seem to recall saif-drivers will need a
> hack then, but Aisheng surely knows better.
> 
Yes, saif driver enables clock until trigger happens. Before that,
it needs set the clock rate as preparation.
Obviously, it cannot work since current clock code does not allow to set rate
before the clock is enabled.

My consider is that can my mxs-specific patchs adding record support go in first
since it's only related to clock driver?
Then this clock issue can be fixed later when move to common clock.

Regards
Dong Aisheng 
