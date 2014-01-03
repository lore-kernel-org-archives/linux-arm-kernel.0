From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 15:49:02 +0100
Subject: [BUG] shmobile build failure
In-Reply-To: <20140102232325.GF7383@n2100.arm.linux.org.uk>
References: <20140102172413.GB7383@n2100.arm.linux.org.uk>
 <CAOesGMh=uWi1gmb_1qhuF42d7Rt85RstvDmPVY2F3_YfkX9xTw@mail.gmail.com>
 <20140102232325.GF7383@n2100.arm.linux.org.uk>
Message-ID: <201401031549.02866.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014, Russell King - ARM Linux wrote:
> On Thu, Jan 02, 2014 at 03:20:36PM -0800, Olof Johansson wrote:
> > On Thu, Jan 2, 2014 at 1:47 PM, Russell King - ARM Linux
> > > Have you run any allmod or allyesconfig builds recently?  The logs from
> > > those builds are excessively big and unreadable due to this:
> > >
> > > warning: __mcount_loc already exists: object-file.o
> > >
> > > being spat out for every object file being built, and I can't figure out
> > > what's causing that.
> > 
> > 
> > Hm, no I have not. Do you have a feel for when it began? I can do a bisect.
> 
> I don't know - I've only recently re-enabled those builds.  There's
> suggestions from other architectures that it may be toolchain related -
> some people have blamed binutils for it, but I'm running binutils 2.22.
> 
> Hence why I'm interested if others see this too.
> 

I just tried building allmodconfig using linux-next-20131224 and
arm-linux-gnueabihf-gcc-4.8.1-7ubuntu1. I had to disable a bunch of
drivers to get it to build, but didn't see the __mcount_loc problem.

What kernel tree and compiler are you using?

	Arnd
