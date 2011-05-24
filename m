From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 May 2011 17:46:59 +0800
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110524072814.GC22096@pengutronix.de>
References: <20110520130721.GD10403@pengutronix.de>
	<alpine.LFD.2.02.1105201518030.3078@ionos>
	<20110521112947.GB11887@sirena.org.uk>
	<20110523062501.GA20715@pengutronix.de>
	<20110523104409.GA15635@opensource.wolfsonmicro.com>
	<20110523144126.GF20715@pengutronix.de>
	<20110523152248.GC6489@sirena.org.uk>
	<20110523164601.GG20715@pengutronix.de>
	<20110523224045.GA19533@opensource.wolfsonmicro.com>
	<20110524072814.GC22096@pengutronix.de>
Message-ID: <20110524094658.GA4005@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 09:28:14AM +0200, Sascha Hauer wrote:
> On Tue, May 24, 2011 at 06:41:00AM +0800, Mark Brown wrote:

> > on systems that do actually have the IRQ range allocated for some other
> > reason.

> By 'some other reason' you mean an implementation bug? If the range is
> already allocated the wm8350 driver should better not use it.

Well, one obvious example is if someone's using the device with a sparse
system already - they'll have had to arrange to allocate the IRQ range
already.
