From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 11 Jul 2011 23:09:39 +0200
Subject: zaurus patches -- arm/pxa -- is Eric alive
In-Reply-To: <CAMPhdO-UjxqyL47VsihX-fBD9VtAKkQqEQGj2u1YG0c90EHfqA@mail.gmail.com>
References: <20110711134150.GA15506@localhost.ucw.cz>
	<CALT56yM+fNs_2QorWK0=gr2um1H3vDX+HXPCi9bmKDdOdSvptA@mail.gmail.com>
	<20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
	<CAMPhdO-UjxqyL47VsihX-fBD9VtAKkQqEQGj2u1YG0c90EHfqA@mail.gmail.com>
Message-ID: <20110711210939.GA5682@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Perhaps the most critical one is:
> >
> > [PATCH] MAX1111: Fix race condition causing NULL pointer exception
> >
> > http://ns1.yosemitephotos.net/lists/arm-kernel/msg125356.html

Yep, that one (or equivalent) is most critical.

> > Which fixes memory corruption that caused random oops.
> >
> > And then there is a bunch of fixes for charging and power management from
> > Pavel Machek:
> 
> Guys, I'm still alive, at least still breathing. Just too many mails
> and I was lost.

Good :-).

> > Disable CF during suspend
> >
> > https://lkml.org/lkml/2011/5/21/46
> 
> The fix is trivial, think I can take it. A better approach will be to have a
> generic CF power control function and invoke it in pcmcia driver when
> suspending.

Please take it. It is also regression from 2.6.15-or-so.

> > and spitz pm
> >
> > https://lkml.org/lkml/2011/5/21/72
> > https://lkml.org/lkml/2011/5/21/73
> > https://lkml.org/lkml/2011/5/21/76
> 
> Looks good to me, yet I need the last one Acked by power supply people.

Can you take the first two? They are trivial preparations... And I'll
get the ACKs...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
