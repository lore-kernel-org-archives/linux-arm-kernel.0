From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 14:00:49 +0000
Subject: [question] NR_IRQS in genirq
In-Reply-To: <alpine.LFD.2.00.1011241453330.2900@localhost6.localdomain6>
References: <AANLkTimoBdFyQ6GfS2DKiF0wdRox0x7MfM0_keD9Z1D0@mail.gmail.com>
	<alpine.LFD.2.00.1011241416360.2900@localhost6.localdomain6>
	<AANLkTik5N0d9wcaiS538UWQ83E_HhXoWC8nMxVY__1+k@mail.gmail.com>
	<20101124135048.GC13507@sirena.org.uk>
	<alpine.LFD.2.00.1011241453330.2900@localhost6.localdomain6>
Message-ID: <20101124140048.GG24970@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 02:54:38PM +0100, Thomas Gleixner wrote:
> On Wed, 24 Nov 2010, Mark Brown wrote:
> > On Wed, Nov 24, 2010 at 09:46:06PM +0800, Haojian Zhuang wrote:

> > Most ARM platforms have come up with some Kconfig gunk to allow boards
> > to extend this for off-SoC GPIOs.  It'd be really nice to get rid of
> > NR_IRQS and stop having to worry about this at all :(

> I mean with sparse_irq you can set NR_IRQS insanely high w/o
> increasing memory consumption. That's the whole point.

Yeah, I was just pointing out common practice on ARM (sparse IRQ isn't
widely enough deployed there :/ ).

Would it be worth having sparse_irq change the default NR_IRQS to be
something suitably large - there doesn't seem any point in having
platforms using it each pick their own particular definition of insanely
high?  I'll take a look and cook up a patch unless I can spot anything
silly about that by myself.
