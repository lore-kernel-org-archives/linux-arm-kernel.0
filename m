From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Aug 2010 13:24:16 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <AANLkTik=sT1wtTJRN--t1Q0+Qna6yX+ycbZ-jO5J=iSR@mail.gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<AANLkTimH9xhjRUaoqr-GMy4gj27VTtrafHU=bqfT6oZ-@mail.gmail.com>
	<20100811105125.GI10432@buzzloop.caiaq.de>
	<201008111255.24657.marek.vasut@gmail.com>
	<AANLkTik=sT1wtTJRN--t1Q0+Qna6yX+ycbZ-jO5J=iSR@mail.gmail.com>
Message-ID: <20100811112416.GJ10432@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 03:10:08PM +0400, Yuri Ludkevich wrote:
> 2010/8/11 Marek Vasut <marek.vasut@gmail.com>
> > Dne St 11. srpna 2010 12:51:25 Daniel Mack napsal(a):
> > > Good. Can you share a patch?
> >
> > nCS3 is the chipselect for CPLD space actually (and the EXT chipselects).
> > If
> > it's configured as nCS3, you can write to the CPLD, but in case you don't
> > need
> > PCMCIA (and ext. chipselects), you should be ok either way.
> >
> > And as Dan said, don't mix GPIO4 and GPIO4_2 :)
> >
> Yep. I know about CPLD. Our board do not use PCMCIA, only SD/MMC. So for us
> it should work.
> 
> But if someone wants to use both PCMCIA and touchscreen - how to configure
> this GPIOs properly?

It won't collide. GPIO4 should be configured to the application function
nCS3, and GPIO4_2 is used as GPIO and interrupt input. The signals
aren't shared on the die, and there are two seperate balls (pins) on the
package.

The only limitation is that you can't use them both as GPIOs, because
GPIO register accesses for GPIO4_2 would also affect GPIO4, and
vice-versa.

And in the setup described above, you would just access GPIO4 and be
fine.

Daniel
