From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Aug 2010 12:12:39 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <AANLkTik+uUTKhXxarS-7PqyOyT8wuOn4WbBM=fHkBZCM@mail.gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<201008111042.52631.marek.vasut@gmail.com>
	<AANLkTimL7kt0-Do9VQUQvktHfsvdKjm_NJ-eDbxcAu2m@mail.gmail.com>
	<201008111107.29839.marek.vasut@gmail.com>
	<20100811094543.GO17833@buzzloop.caiaq.de>
	<AANLkTim+kNyEL2s0k9wLoctRMKDWoaYy66y=adhog1wc@mail.gmail.com>
	<20100811100210.GP17833@buzzloop.caiaq.de>
	<AANLkTik+uUTKhXxarS-7PqyOyT8wuOn4WbBM=fHkBZCM@mail.gmail.com>
Message-ID: <20100811101239.GR17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 02:08:10PM +0400, Yuri Ludkevich wrote:
> 2010/8/11 Daniel Mack <daniel@caiaq.de>
> > Yes, they are aliases to the signals without the "_2" suffix. Quoting
> > the PXA reference manual, chapter 5.3:
> >
> > GPIO<6_0>_2:
> >
> > General-Purpose IO Ports, second instantiation. The same signals as
> > GPIO<6:0>, but they are given separate names because they are configured
> > on separate multi-function pins. The recommended configuration is for
> > both multi-function pin instantiations of these GPIOs not to be
> > configured simultaneously for GPIO functionality. The preferred
> > configuration for dual instantiation GPIO usage (that is, using both
> > GPIO<6:0> and GPIO<6:0>_2 functions) is to configure one multi-function
> > pin as a GPIO and the second multi-function pin instantiation for an
> > alternate function other than a GPIO function. Configuring GPIO<6:0> to
> > be present on two separate multi-function pins is not recommended.
> > However, when GPIO<6:0> is configured as an output and both
> > multi-function pin instantiations are programmed for GPIO function, the
> > primary and secondary instantiation of the multi-function pins are both
> > outputs from the common GGPIO<6:0> signal. However, when GPIO<6:0> is an
> > input, the inputs from both multi-function pin instantiations are ORed
> > together before the result is sent to the internal GPIO<6:0> input
> > logic.
> 
> Hmmm. I found with pxaregs tool what both GPIO4 and GPIO4_2 configured as
> GPIO. May be this cause irq autodetection to fail?

No - if you don't tell the driver which GPIO the interrupt line is
connected to, it can't know. But as the reference manual says, such
configurations should be avoided.

You're welcome to come up with a patch :)

Daniel
