From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 14:45:56 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <1263997609.4283.1067.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
	<1263996080.4283.1064.camel@laptop> <op.u6t4atd07p4s8u@pikus>
	<1263996979.4283.1066.camel@laptop>
	<1263997609.4283.1067.camel@laptop>
Message-ID: <20100120144556.GC22897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 03:26:49PM +0100, Peter Zijlstra wrote:
> On Wed, 2010-01-20 at 15:16 +0100, Peter Zijlstra wrote:
> > On Wed, 2010-01-20 at 15:09 +0100, Micha? Nazarewicz wrote:
> > > On Wed, 20 Jan 2010 15:01:20 +0100, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > It seems to me userspace might care about the exact platform they're
> > > > running on.
> > > 
> > > In my humble opinion, user space should never care about platform it's
> > > running on.  Interfaces provided by kernel should suffice to implement
> > > abstraction layer between user space and hardware.  If we abandon that
> > > we're back in DOS times.  But hey, again, that's just my opinion.
> > 
> > Well, you're completely right. But the often sad reality is that perfect
> > abstraction is either impossible or prohibitively expensive.
> 
> And then there is the simple matter of knowing what kind of box it is
> without having to resort to a screwdriver or worse.

If you're expecting the CPU to tell you that, give up now.  The CPU
will tell you about the CPU core, not the SoC.

All SoCs that have an ARM926 core in report that they are an ARM926
CPU; that doesn't tell you that the surrounding hardware is an Atmel
SoC, Samsung SoC, etc.

Even some buggy CPUs which aren't an ARM926 report themselves as an
ARM926 (Feroceon) while being incompatible with the ARM926 on several
levels.  (Apparantly, the argument being that they wanted ARM926
software to run on Feroceon, or something like that.)

That's why we have the value passed in from the boot loader; there's
no other way to tell what SoC you're running on.
