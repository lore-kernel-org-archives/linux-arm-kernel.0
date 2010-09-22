From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Sep 2010 11:54:39 +0100
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <20100922105111.GA20986@sirena.org.uk>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>
	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
	<alpine.LFD.2.00.1009212342580.2416@localhost6.localdomain6>
	<AANLkTinrfJkK85v2epOY95YWaVyMBcxSF2xakHqsM7vh@mail.gmail.com>
	<20100922105111.GA20986@sirena.org.uk>
Message-ID: <20100922105439.GB20986@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 11:51:11AM +0100, Mark Brown wrote:
> On Wed, Sep 22, 2010 at 12:08:17AM -0300, Grant Likely wrote:

> > What's the irq handling latency on those?  Glad I haven't had to deal
> > with any of them yet.

> Milisecondish, but depends on bus congestion and bus type.  You need to
> schedule a thread which then does one but typically more register I/O
> operations on the device (read one or more IRQ status registers, and
> typically write back to acknowledge the interrupts as well).  These tend
> for obvious reasons to be for low volume interrupts like jack detection.

Incidentally, if you want to look at an implementation the wm831x
contains an implementation of such a controller (in drivers/mfd/wm831x-irq.c)
the structure of which has been cloned for quite a few of these chips.
