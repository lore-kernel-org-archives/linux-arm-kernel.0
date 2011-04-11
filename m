From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 14:52:16 +0100
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <20110411134320.GJ18601@pengutronix.de>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<20110411134320.GJ18601@pengutronix.de>
Message-ID: <20110411135215.GD2818@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Apr 11, 2011 at 03:43:20PM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Apr 11, 2011 at 12:48:17PM +0100, Jamie Iles wrote:
> > The basic-mmio-gpio driver has been extended in
> > <http://marc.info/?l=linux-kernel&m=130252092900804&w=2> to support a
> > larger wider of controllers and this series converts the ARM platforms
> > that do not implement I/O muxing in the GPIO driver or use the .to_irq
> > method of gpio_chip to use the driver.
> As these patches are necessary to test at least the mxc patch but they
> are not present in todays next and I don't want to spend the time to
> find the patches on marc.info (the "next in thread" link is greyed out)
> and it's non-trivial to get patches from marc into git (
> wget -O - 'http://marc.info/?l=linux-kernel&m=130252092900807&q=raw' | git am
> fails with "Patch does not have a valid e-mail address." because the raw
> view doesn't provide the From: header (Subject: is missing, too)) can
> you please point out a repository that has all 12 patches?

Sure, they're all in:

	git://github.com/jamieiles/linux-2.6-ji.git gpio

There's one extra slightly unrelated fix for gemini in there too.

> Did you (or someone else) measure the performance difference these
> patches introduce?

No, I haven't done any performance measurement, though from inspection I 
don't think that I would expect any real measurable difference.

Jamie
