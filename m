From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 30 Nov 2010 20:19:14 +0100
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <20101116200426.75085b68@lxorguk.ukuu.org.uk>
References: <i9kk4o$svc$1@dough.gmane.org> <4CC418A9.6090602@evidence.eu.com>
	<4CDA630F.4060903@atmel.com> <20101110172842.GC12371@suse.de>
	<4CDBC3EC.6020707@evidence.eu.com> <20101116143016.GB6527@ucw.cz>
	<AANLkTi=grehSnfWzCDtSXXmNb=-NAwbHHJ_P1XPyOuw8@mail.gmail.com>
	<20101116172013.102e06a6@lxorguk.ukuu.org.uk>
	<ibuh1v$uh6$1@dough.gmane.org>
	<20101116200426.75085b68@lxorguk.ukuu.org.uk>
Message-ID: <20101130191913.GA5295@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2010-11-16 20:04:26, Alan Cox wrote:
> > Comtrol, Moxa, B&B, Sealevel, and others all sell PCI cards and
> > Ethernet attached serial ports that have selectable interfaces
> > (typically RS-232/422/485).  Comtrol and Moxa have had drivers in the
> > kernel tree for ages, but they've always had to use custom ioctl calls
> > for things like configuring 232/485/422 mode and half/full-duplex
> > mode.
> 
> Ok so what is needed that isn't covered by the current termiox and
> TIOCG/SRS485 ioctls ?

IIRC selection of 232/485/422 mode was missing from proposed api.

> > Having a standard API for things like interface mode, half-full
> > duplex, inter-character timeout, 9-bit mode, and so on would be life a
> > lot easier for those of us who maintain Linux serial drivers...
> 
> 9bit mode is a real problem with the tty layer defined in terms of 8bit
> streams but yes.

Well, if you wanted to have some fun... kontron card is able to
timestamp incoming characters, and saves state of the control signals
when character is received...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
