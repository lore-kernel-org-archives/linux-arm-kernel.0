From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 17 Jan 2010 14:07:39 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <201001162326.09092.rjw@sisk.pl>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001162305.56972.rjw@sisk.pl> <20100116221929.GB8425@elf.ucw.cz>
	<201001162326.09092.rjw@sisk.pl>
Message-ID: <20100117130739.GA2035@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > That was not the point I was trying to discuss. Yes, we need
> > kernel<->user notification of battery critical. 
> > 
> > But on zaurus, correct action is to suspend (not hibernate and not
> > poweroff) when battery is no longer able to supply enough power to
> > keep system alive.
> 
> Why not to poweroff (just asking, I don't know that hardware)?

Those machines basically have no poweroff.

> I guess we should at least do our best to keep filesystems in a consistent
> state and suspend doesn't really guarantee this if the system remains on
> battery power afterwards.

I'm not sure if I ever had battery run so low that it could not keep
RAM running. Collie has even separate (small) battery just for
RAM. (And it also has all the filesystems in ramdisk -- you really do
not want to power it off, even if it could.)

AFAICT following message would be nice.

1) battery is critical, userspace please do something

On zaurus and similar, you could add

2) oh and btw we had power failure so we suspended (or maybe -- so
hardware suspended itself -- rmk's examples and old apm systems); we
are now back and running

notification... but... ideally those power failures should never
happen anyway, so... having this notification is in no way neccessary.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
