From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Apr 2011 00:10:54 +0200
Subject: [RFC PATCH v2 1/3] PM / Core: suspend_again callback for
	device PM.
In-Reply-To: <201104262346.58046.rjw@sisk.pl>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<201104262247.44113.rjw@sisk.pl>
	<20110426210627.GA28033@elf.ucw.cz>
	<201104262346.58046.rjw@sisk.pl>
Message-ID: <20110426221054.GB29092@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > And that's exactly what should be done.  Have a user space process controlling
> > > that, because avoiding to thaw user space doesn't buy us almost
> > > anything.
> > 
> > That makes Zaurus implement different user-kernel interface than PC
> > class machine, because of hardware quirk.
> 
> Let me say that again: If Zaurus needs to resume everything except for
> user space periodically to monitor the battery charger, I'm not sure if our
> suspend interface is the right one for it in the first place.

Well, Zaurus does not need to resume everything. SPI+charger code is
enough, and that would be preffered. No need to touch disk etc.

> It seriously looks like a workaround for the lack of appropriately implemented
> runtime PM, just like the Android's opportunistic suspend.

No, not really. I'm running standard Debian; I do not want/need
anything like opportunistic suspend.

> > > Now, I know that it's probably easier to modify the kernel than to write
> > > a user space tool for that, test it and so on, but "easier" is not necessarily
> > > "better".
> > 
> > It is easier, allows us to keep same user-kernel interface on PC and
> > Zaurus, and is compatible with 2.6.38.
> > 
> > Heck, I'm used to typing "echo mem > /sys/power/state". I should not
> > have to learn different interface just because Zaurus does not have
> > proper hardware charger.
> 
> No, this interface should not be used on Zaurus at all.  It's not mean for
> that and while you can hack it to kind of work, it still is hacking rather
> than designing things.

Why not? I want the Zaurus to sleep. Why should I have to know how its
charging unit works? Why should I use different interface than on PC?
I want it to suspend, put it into backpack and move...

> > Bootloader takes care of battery in that case.
> 
> So the difference is that we let someone else worry.  Cool. :-)

Yes.

> > Ok, see the spitz_should_wakeup() function in arch/arm/mach-pxa/* and
> > should_wakeup() usage.
> 
> OK, I will.

Thanks.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
