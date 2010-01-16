From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 16 Jan 2010 23:31:15 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <20100116222529.GA8618@elf.ucw.cz>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<20100116221929.GB8425@elf.ucw.cz>
	<20100116222529.GA8618@elf.ucw.cz>
Message-ID: <201001162331.15405.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 January 2010, Pavel Machek wrote:
> > > IMHO it should just plain shutdown in that case.  Suspending doesn't really
> > > solve the problem, because the battery is going to drain still.  Unless you
> > > mean suspend=hibernate, but I guess you don't.
> 
> BTW I was talking spitz before, but there's collie, too. It was
> shipped in configuration where all user data was in RAM and RAMdisk --
> no writable flash. On such machine, shutdown is never option. (And
> yes, such design was very common in windowsCE days).
> 
> Spitz got disk, but inherited that powermanagement design; and it
> works very well.
> 
> And now, if you want collie for a year (or two), you can have
> mine... it still works and battery still lasted for 5 hours 2 years
> ago -- not bad for 10 year old battery. You'll note that it is very
> different design from PC.

Well, I guess I wouldn't have the time to study it anyway, so thanks. :-)

All in all, it looks like these particular platforms are just specific design
having special requirements.  And even on these platforms sending a battery
critical notification to the user space before the kernel emergency suspends
(or shuts down or whatever) the system seems to be a good idea in general.

Rafael
