From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 May 2011 13:52:15 +0200
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110524094658.GA4005@opensource.wolfsonmicro.com>
References: <alpine.LFD.2.02.1105201518030.3078@ionos>
	<20110521112947.GB11887@sirena.org.uk>
	<20110523062501.GA20715@pengutronix.de>
	<20110523104409.GA15635@opensource.wolfsonmicro.com>
	<20110523144126.GF20715@pengutronix.de>
	<20110523152248.GC6489@sirena.org.uk>
	<20110523164601.GG20715@pengutronix.de>
	<20110523224045.GA19533@opensource.wolfsonmicro.com>
	<20110524072814.GC22096@pengutronix.de>
	<20110524094658.GA4005@opensource.wolfsonmicro.com>
Message-ID: <20110524115215.GD22096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 05:46:59PM +0800, Mark Brown wrote:
> On Tue, May 24, 2011 at 09:28:14AM +0200, Sascha Hauer wrote:
> > On Tue, May 24, 2011 at 06:41:00AM +0800, Mark Brown wrote:
> 
> > > on systems that do actually have the IRQ range allocated for some other
> > > reason.
> 
> > By 'some other reason' you mean an implementation bug? If the range is
> > already allocated the wm8350 driver should better not use it.
> 
> Well, one obvious example is if someone's using the device with a sparse
> system already - they'll have had to arrange to allocate the IRQ range
> already.

There seems to be no user in the kernel. Anyway, sooner or later we'll
have the same problem with other mfd drivers. So what do yuo suggest?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
