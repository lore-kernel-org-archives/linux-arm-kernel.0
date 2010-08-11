From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Aug 2010 14:35:51 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <AANLkTik_7bZMuWDv__Md8zGhXzczjGYSVjtoqCxeMn7L@mail.gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<AANLkTimH9xhjRUaoqr-GMy4gj27VTtrafHU=bqfT6oZ-@mail.gmail.com>
	<20100811105125.GI10432@buzzloop.caiaq.de>
	<201008111255.24657.marek.vasut@gmail.com>
	<AANLkTik=sT1wtTJRN--t1Q0+Qna6yX+ycbZ-jO5J=iSR@mail.gmail.com>
	<20100811112416.GJ10432@buzzloop.caiaq.de>
	<AANLkTik_7bZMuWDv__Md8zGhXzczjGYSVjtoqCxeMn7L@mail.gmail.com>
Message-ID: <20100811123551.GT17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 04:32:48PM +0400, Yuri Ludkevich wrote:
> 2010/8/11 Daniel Mack <daniel@caiaq.de>
> > It won't collide. GPIO4 should be configured to the application function
> > nCS3, and GPIO4_2 is used as GPIO and interrupt input. The signals
> > aren't shared on the die, and there are two seperate balls (pins) on the
> > package.
> >
> > The only limitation is that you can't use them both as GPIOs, because
> > GPIO register accesses for GPIO4_2 would also affect GPIO4, and
> > vice-versa.
> >
> > And in the setup described above, you would just access GPIO4 and be
> > fine.
> >
> > Daniel
> >
> 
> Which list i should use to send patch?  linux-arm-kernel at lists.infradead.orgor
> openpxa-users at lists.sourceforge.net? or both?

It will be merged to the kernel source code eventually, so send it to
linux-arm-kernel, but you can copy openpxa-users as well if you like.

> sorry for dumb question, but it my first expirience of sending patches =)

No problem at all :)
