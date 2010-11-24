From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 24 Nov 2010 14:54:38 +0100 (CET)
Subject: [question] NR_IRQS in genirq
In-Reply-To: <20101124135048.GC13507@sirena.org.uk>
References: <AANLkTimoBdFyQ6GfS2DKiF0wdRox0x7MfM0_keD9Z1D0@mail.gmail.com>
	<alpine.LFD.2.00.1011241416360.2900@localhost6.localdomain6>
	<AANLkTik5N0d9wcaiS538UWQ83E_HhXoWC8nMxVY__1+k@mail.gmail.com>
	<20101124135048.GC13507@sirena.org.uk>
Message-ID: <alpine.LFD.2.00.1011241453330.2900@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Nov 2010, Mark Brown wrote:

> On Wed, Nov 24, 2010 at 09:46:06PM +0800, Haojian Zhuang wrote:
> 
> > My hardware environment is ARM. Each machine description can specify
> > nr_irqs. In my implementation of PXA, NR_IRQS is fixed for SoC
> > internal IRQs. And there's some additional board IRQs, we arrange them
> > between NR_IRQS and nr_irqs. So nr_irqs will be larger than NR_IRQS if
> > board IRQs exists.
> 
> Most ARM platforms have come up with some Kconfig gunk to allow boards
> to extend this for off-SoC GPIOs.  It'd be really nice to get rid of
> NR_IRQS and stop having to worry about this at all :(

I mean with sparse_irq you can set NR_IRQS insanely high w/o
increasing memory consumption. That's the whole point.

Thanks,

	tglx
