From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 13:50:49 +0000
Subject: [question] NR_IRQS in genirq
In-Reply-To: <AANLkTik5N0d9wcaiS538UWQ83E_HhXoWC8nMxVY__1+k@mail.gmail.com>
References: <AANLkTimoBdFyQ6GfS2DKiF0wdRox0x7MfM0_keD9Z1D0@mail.gmail.com>
	<alpine.LFD.2.00.1011241416360.2900@localhost6.localdomain6>
	<AANLkTik5N0d9wcaiS538UWQ83E_HhXoWC8nMxVY__1+k@mail.gmail.com>
Message-ID: <20101124135048.GC13507@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 09:46:06PM +0800, Haojian Zhuang wrote:

> My hardware environment is ARM. Each machine description can specify
> nr_irqs. In my implementation of PXA, NR_IRQS is fixed for SoC
> internal IRQs. And there's some additional board IRQs, we arrange them
> between NR_IRQS and nr_irqs. So nr_irqs will be larger than NR_IRQS if
> board IRQs exists.

Most ARM platforms have come up with some Kconfig gunk to allow boards
to extend this for off-SoC GPIOs.  It'd be really nice to get rid of
NR_IRQS and stop having to worry about this at all :(
