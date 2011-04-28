From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 28 Apr 2011 17:19:10 +0000
Subject: [PATCH] msm: watchdog: support watchdog on 8x60 and 8960
In-Reply-To: <20110330161419.GB28252@pulham.picochip.com>
References: <1301105894-22835-1-git-send-email-johlstei@codeaurora.org>
	<1301426560.4049.0.camel@m0nster> <4D92B43B.5050101@codeaurora.org>
	<1301501006.5346.2.camel@m0nster>
	<20110330161419.GB28252@pulham.picochip.com>
Message-ID: <20110428171909.GC7345@localhost.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It doesn't sound too different that all the other watchdogs in
> > drivers/watchdog/ .. Your just detecting lockups right?
> 
> There are some watchdogs in there such as 
> drivers/watchdog/at91sam9_wdt.c that can't be stopped once enabled so 
> the driver sets up a soft timer in the kernel that kicks the watchdog to 
> prevent the system rebooting.
> 
> With this approach you could have the watchdog always enabled and being 
> kicked even if the userspace daemon wasn't running, but with the 
> flexibility of kicking it from userspace if you wanted.

sounds like a way to do it.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
