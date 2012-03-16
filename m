From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 16:28:15 -0400
Subject: [PATCH 0/9 v5] ARM: kirkwood: fdt: convert kirkwood to fdt
In-Reply-To: <201203162018.27957.arnd@arndb.de>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <cover.1331868507.git.jason@lakedaemon.net>
 <201203162018.27957.arnd@arndb.de>
Message-ID: <20120316202815.GI20243@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 08:18:27PM +0000, Arnd Bergmann wrote:
> On Friday 16 March 2012, Jason Cooper wrote:
> > 
> > This series continues the process of converting all of the drivers initialized
> > from kirkwood_init() to devicetree.
> > 
> > The first three patches are code cleanup from Andrew Lunn and myself.
> > 
> > The next three patches are cleanup and prep to facilitate adding new boards
> > during the transition to devicetree.
> > 
> > The next patch moves the uarts into the bus for all kirkwood boards and leaves
> > enabling them and specifying clock-frequency up to the board file.
> > 
> > The rest of the series is the initial conversion of rtc-mv to devicetree since
> > it  doesn't use tclk or pinmux.  These should be safe to merge as they won't
> > interfere with the clk/clkdev work Andrew Lunn is working on.
> > 
> >
> > Please be aware that this is a complete reshuffle of the whole series and is
> > based purely against arm-soc/next/boards.
> 
> Is this a pull request for v3.4 or not?

I was going to give it a day or two more, and if no one brought up
anything earth-shattering, I was going to submit the pull-request for
this series on Sunday.  I can do it now if you think it's ok.

> I'm willing to take it and have put it into next/dt2 for now so it
> makes it into linux-next. I'm not taking a newer version for v3.4 any
> more, so if anyone has concerns over some of your patches in the
> series, it all gets removed again and we will have to postpone them
> until v3.5.

The problematic patch (sata_mv) has been removed.  So, there should be
no issue.

> Note that it would have been better to base your series on top of just
> the kirkwood/board branch rather than all of next/boards, but it's not
> a big deal.

Ok.

thx,

Jason.
