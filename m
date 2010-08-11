From: urx.forever@gmail.com (Yuri Ludkevich)
Date: Wed, 11 Aug 2010 12:32:55 -0000
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <20100811112416.GJ10432@buzzloop.caiaq.de>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<AANLkTimH9xhjRUaoqr-GMy4gj27VTtrafHU=bqfT6oZ-@mail.gmail.com>
	<20100811105125.GI10432@buzzloop.caiaq.de>
	<201008111255.24657.marek.vasut@gmail.com>
	<AANLkTik=sT1wtTJRN--t1Q0+Qna6yX+ycbZ-jO5J=iSR@mail.gmail.com>
	<20100811112416.GJ10432@buzzloop.caiaq.de>
Message-ID: <AANLkTik_7bZMuWDv__Md8zGhXzczjGYSVjtoqCxeMn7L@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/11 Daniel Mack <daniel@caiaq.de>

> On Wed, Aug 11, 2010 at 03:10:08PM +0400, Yuri Ludkevich wrote:
> > 2010/8/11 Marek Vasut <marek.vasut@gmail.com>
> > > Dne St 11. srpna 2010 12:51:25 Daniel Mack napsal(a):
> > > > Good. Can you share a patch?
> > >
> > > nCS3 is the chipselect for CPLD space actually (and the EXT
> chipselects).
> > > If
> > > it's configured as nCS3, you can write to the CPLD, but in case you
> don't
> > > need
> > > PCMCIA (and ext. chipselects), you should be ok either way.
> > >
> > > And as Dan said, don't mix GPIO4 and GPIO4_2 :)
> > >
> > Yep. I know about CPLD. Our board do not use PCMCIA, only SD/MMC. So for
> us
> > it should work.
> >
> > But if someone wants to use both PCMCIA and touchscreen - how to
> configure
> > this GPIOs properly?
>
> It won't collide. GPIO4 should be configured to the application function
> nCS3, and GPIO4_2 is used as GPIO and interrupt input. The signals
> aren't shared on the die, and there are two seperate balls (pins) on the
> package.
>
> The only limitation is that you can't use them both as GPIOs, because
> GPIO register accesses for GPIO4_2 would also affect GPIO4, and
> vice-versa.
>
> And in the setup described above, you would just access GPIO4 and be
> fine.
>
> Daniel
>

Which list i should use to send patch?  linux-arm-kernel at lists.infradead.orgor
openpxa-users at lists.sourceforge.net? or both?

sorry for dumb question, but it my first expirience of sending patches =)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100811/c8f48afd/attachment-0001.html>
