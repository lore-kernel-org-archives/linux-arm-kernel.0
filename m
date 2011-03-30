From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 30 Mar 2011 17:14:19 +0100
Subject: [PATCH] msm: watchdog: support watchdog on 8x60 and 8960
In-Reply-To: <1301501006.5346.2.camel@m0nster>
References: <1301105894-22835-1-git-send-email-johlstei@codeaurora.org>
	<1301426560.4049.0.camel@m0nster> <4D92B43B.5050101@codeaurora.org>
	<1301501006.5346.2.camel@m0nster>
Message-ID: <20110330161419.GB28252@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 09:03:26AM -0700, Daniel Walker wrote:
> On Tue, 2011-03-29 at 21:40 -0700, Jeff Ohlstein wrote:
> > Daniel Walker wrote:
> > > Are you saying this is mostly a debugging facility ? The interrupts off
> > > thing I can see as just debugging, but I don't understand the bus
> > > lockups part.
> > >   
> > 
> > It isn't just a debugging facility. It is still beneficial to the end user
> > in that it restarts the system if there is a bus lockup or a faulty 
> > interrupt
> > handler in a rarely used codepath. This is better than the alternative 
> > of draining
> > the battery and turning off. We want this to be turned on independent of 
> > what userspace
> > one is using, unless they explicitly turn it off themselves.
> 
> It doesn't sound too different that all the other watchdogs in
> drivers/watchdog/ .. Your just detecting lockups right?

There are some watchdogs in there such as 
drivers/watchdog/at91sam9_wdt.c that can't be stopped once enabled so 
the driver sets up a soft timer in the kernel that kicks the watchdog to 
prevent the system rebooting.

With this approach you could have the watchdog always enabled and being 
kicked even if the userspace daemon wasn't running, but with the 
flexibility of kicking it from userspace if you wanted.

Jamie
