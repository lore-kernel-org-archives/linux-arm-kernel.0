From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 16 Jan 2010 23:07:48 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <20100116181211.GA1603@ucw.cz>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001152314.30355.rjw@sisk.pl> <20100116181211.GA1603@ucw.cz>
Message-ID: <201001162307.48085.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 January 2010, Pavel Machek wrote:
> Hi!
> 
> > > > I wasn't aware of this.
> > > > 
> > > > That may be a good reason for adding kernel-based suspend notification,
> > > > although I'd prefer ARM to notify the user space about the critical battery
> > > > status allowing it to decide what to do.
> > > 
> > > Hard to do, without breaking compatibility that goes down to 2.4.X.
> > 
> > Sending a battery-critical notification to the user space is not equivalent to
> > removing the existing kernel-based mechanism.  They can exist both at the
> > same time if the notification is sent earlier than the kernel suspends
> > everything. 
> 
> Yes, and obviously sending notification early is ok with me.
> 
> > > It really makes sense on zaurus. Those machines are simple, no
> > > smartbattery and no embedded controller subsystems. Battery will not
> > > protect itself, and its kernel job. (Should work on init=/bin/bash).
> > > 
> > > As power-off consumption is same as suspend power consumption (I
> > > beleive zaurus simply does not have true power off), suspend on
> > > critical makes some sense. (Note that it is set lower than on pcs, and
> > > that we declare battery critical sooner than that.)
> > 
> > The problem with that is it catches at least some applications unprepared and
> > notifying them that "we're suspending right now" doesn't really help, because
> > they won't have any time to react anyway.
> 
> Agreed, but so what? On PC, machine would power off at that
> point. That would surprise the apps, too.
> 
> Basically new enough userland should not make battery run low enough
> for either emergency power off or emergency suspend.

I wonder how it is supposed to achieve that without knowing the current battery
status.  Do you mean it should poll the battery driver?

Rafael
