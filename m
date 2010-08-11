From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Aug 2010 12:02:10 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <AANLkTim+kNyEL2s0k9wLoctRMKDWoaYy66y=adhog1wc@mail.gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<201008111042.52631.marek.vasut@gmail.com>
	<AANLkTimL7kt0-Do9VQUQvktHfsvdKjm_NJ-eDbxcAu2m@mail.gmail.com>
	<201008111107.29839.marek.vasut@gmail.com>
	<20100811094543.GO17833@buzzloop.caiaq.de>
	<AANLkTim+kNyEL2s0k9wLoctRMKDWoaYy66y=adhog1wc@mail.gmail.com>
Message-ID: <20100811100210.GP17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You dropped all recipients again and only replied to me.
PLEASE DON'T DO THAT.
Always keep all people in the loop, always.

On Wed, Aug 11, 2010 at 01:50:43PM +0400, Yuri Ludkevich wrote:
> 2010/8/11 Daniel Mack <daniel@caiaq.de>
> > According to my reverse engineering, this should be GPIO4_2.
> >
> 
> Thanks a lot.
> 
> BTW: does /sys/class/gpio/export support GPIOX_2 pins?

Yes, they are aliases to the signals without the "_2" suffix. Quoting
the PXA reference manual, chapter 5.3:

GPIO<6_0>_2:

General-Purpose IO Ports, second instantiation. The same signals as
GPIO<6:0>, but they are given separate names because they are configured
on separate multi-function pins. The recommended configuration is for
both multi-function pin instantiations of these GPIOs not to be
configured simultaneously for GPIO functionality. The preferred
configuration for dual instantiation GPIO usage (that is, using both
GPIO<6:0> and GPIO<6:0>_2 functions) is to configure one multi-function
pin as a GPIO and the second multi-function pin instantiation for an
alternate function other than a GPIO function. Configuring GPIO<6:0> to
be present on two separate multi-function pins is not recommended.
However, when GPIO<6:0> is configured as an output and both
multi-function pin instantiations are programmed for GPIO function, the
primary and secondary instantiation of the multi-function pins are both
outputs from the common GGPIO<6:0> signal. However, when GPIO<6:0> is an
input, the inputs from both multi-function pin instantiations are ORed
together before the result is sent to the internal GPIO<6:0> input
logic.


HTH,
Daniel
