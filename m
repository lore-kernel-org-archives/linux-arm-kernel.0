From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 9 Feb 2013 17:28:14 +0100
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <CACRpkda1+EXuRZacPu2_p9XxL2F1hiy7g74Qb35EArAPkvY8VA@mail.gmail.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkda1+EXuRZacPu2_p9XxL2F1hiy7g74Qb35EArAPkvY8VA@mail.gmail.com>
Message-ID: <20130209162814.GA27235@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> <thomas.petazzoni@free-electrons.com> wrote:
> 
> > This patch series implements a simple driver for 7-segment displays
> > connected over GPIOs through a BCD encoder. The userspace interface of
> > the driver is very simple: just a "value" file in the sysfs directory
> > of the device, which can be written to (changes the value shown on the
> > 7-segment display) and read (gives the current value).
> 
> The ARM Integrator AP and CP base boards I have here have
> 7-segment displays as well. But it's not on GPIO but dedicated
> registers, so I could implement these as, e.g. LEDs.
> 
> But with this framework I'd just make a driver that pokes directly
> into the registers.
> 
> However as Russell points out, this needs to be thought through.
> I have a period on my display between the two characters, so
> how do we model that period?

Well, 7 segment display can be used for 0-9 A-F (very readable) and
0-9 a-z if you stretch stuff a bit, as done on TI chronos for
example... Would it make sense to simply display a string? Up to four
letters with up-to 4 '.' space characters...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
