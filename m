From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 9 Nov 2010 19:51:45 +0900
Subject: [PATCH 6/6 v3] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <20101109103312.GA2869@n2100.arm.linux.org.uk>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
	<20101108041721.GA11605@linux-sh.org>
	<20101108141407.GA25739@alchark-u3s.lan>
	<20101108204315.GA12050@linux-sh.org>
	<20101109103312.GA2869@n2100.arm.linux.org.uk>
Message-ID: <20101109105144.GA22389@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 10:33:12AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 09, 2010 at 05:43:16AM +0900, Paul Mundt wrote:
> > > diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> > > new file mode 100644
> > > index 0000000..640d8a3
> > > --- /dev/null
> > > +++ b/drivers/video/vt8500lcdfb.c
> > > +#include <asm/irq.h>
> > > +
> > linux/irq.h is preferred here.
> 
> I assume you've read the comment at the top of linux/irq.h ?

I had forgotten about that. This comment predates git, so I'm unaware of
what the context is, could you elaborate on it?

I'm aware this won't work for s390, but as that has NO_IOMEM in the
first place it's a non-issue. I assume this was added at a time before
ARM selected GENERIC_HARDIRQS, but this is no longer the case.

The odd ones out that do support iomem are m68k and sparc32, both of
which are being converted. Given that and that s390 remains special
cased for now, what exactly is the concern?

There is a reasonable expectation that we will start to see irq_data
references in drivers, so it's not entirely obvious that the assertion
made by the comment will remain true (all of the stragglers have work in
progress patches already, as far as I'm aware).
