From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 May 2011 23:35:46 +0800
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110524115215.GD22096@pengutronix.de>
References: <20110521112947.GB11887@sirena.org.uk>
	<20110523062501.GA20715@pengutronix.de>
	<20110523104409.GA15635@opensource.wolfsonmicro.com>
	<20110523144126.GF20715@pengutronix.de>
	<20110523152248.GC6489@sirena.org.uk>
	<20110523164601.GG20715@pengutronix.de>
	<20110523224045.GA19533@opensource.wolfsonmicro.com>
	<20110524072814.GC22096@pengutronix.de>
	<20110524094658.GA4005@opensource.wolfsonmicro.com>
	<20110524115215.GD22096@pengutronix.de>
Message-ID: <20110524153521.GH7945@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 01:52:15PM +0200, Sascha Hauer wrote:
> On Tue, May 24, 2011 at 05:46:59PM +0800, Mark Brown wrote:

> > Well, one obvious example is if someone's using the device with a sparse
> > system already - they'll have had to arrange to allocate the IRQ range
> > already.

> There seems to be no user in the kernel. Anyway, sooner or later we'll
> have the same problem with other mfd drivers. So what do yuo suggest?

The other MFD drivers are exactly my issue here, obviously all these
devices have pretty much the same code and we should be doing the same
thing with all of them.  I've got a good idea about users for drivers I
maintain but less so for others.
