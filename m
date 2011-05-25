From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 May 2011 17:23:17 +0800
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110525081326.GK20715@pengutronix.de>
References: <20110523104409.GA15635@opensource.wolfsonmicro.com>
	<20110523144126.GF20715@pengutronix.de>
	<20110523152248.GC6489@sirena.org.uk>
	<20110523164601.GG20715@pengutronix.de>
	<20110523224045.GA19533@opensource.wolfsonmicro.com>
	<20110524072814.GC22096@pengutronix.de>
	<20110524094658.GA4005@opensource.wolfsonmicro.com>
	<20110524115215.GD22096@pengutronix.de>
	<20110524153521.GH7945@opensource.wolfsonmicro.com>
	<20110525081326.GK20715@pengutronix.de>
Message-ID: <20110525092315.GA10526@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 10:13:26AM +0200, Sascha Hauer wrote:

> Ok, how about this?

> - Add a ALLOC_DESCS flag to platform data
> - Without platform data are descs are dynamically allocated
> - With platform data and ALLOC_DESCS not set: no dynamically
>   allocated descs, no change at all
> - With ALLOC_DESCS set descs are dynamically allocated with:
>   - if irq_base is 0, the some range is allocated
>   - with irq_base != 0, exactly irq_base + num is allocated

> I also wonder if we should spill out a warning when ALLOC_DESCS is not
> set. It basically means that we may use some otherwise used resources.

I dunno, that seems painful.  Perhaps we just accept that some boards
will be broken if things go wrong - the whole ALLOC_DESCS thing seems
more pain than it's worth.
