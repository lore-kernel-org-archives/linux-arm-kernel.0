From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Apr 2012 10:47:04 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411094231.GO3852@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411092034.GV24211@n2100.arm.linux.org.uk>
 <20120411094231.GO3852@pengutronix.de>
Message-ID: <20120411094704.GY24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:42:31AM +0200, Sascha Hauer wrote:
> On Wed, Apr 11, 2012 at 10:20:34AM +0100, Russell King - ARM Linux wrote:
> > Yes, and you're not the only one who has that concern.  What this patch
> > does is turn a pair of string compares through a table into that plus
> > another set of string compares across all struct clk, which will make
> > the lookup yet more expensive.
> > 
> > I see no reason why you'd register the cl_lookup structures before you
> > know about which clks actually exist - and if they already exist, then
> > you can already find the struct clk pointer and use that to register
> > the proper return value for clk_get() via the clkdev APIs.
> 
> Indeed I have struct clk pointers, so I can instead use a to-be-written
> combination of clkdev_alloc/clkdev_add. Would that be ok?

As we already have clkdev_alloc and clkdev_add, then I don't see that as
a problem - except we may have to change __clkdev_alloc() so that it can
be used before kmalloc() is up and running.
