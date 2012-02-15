From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 15 Feb 2012 10:34:26 +0200
Subject: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug support
In-Reply-To: <20120214235218.GX1426@atomide.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com>
 <20120214202740.GT1426@atomide.com> <87fwed58dm.fsf@ti.com>
 <20120214235218.GX1426@atomide.com>
Message-ID: <1329294866.4102.343.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-14 at 15:52 -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [120214 14:28]:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
> > > * Tero Kristo <t-kristo@ti.com> [120214 08:19]:
> > >> Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
> > >> their own file, 'usecount'. This file shows the usecounts for every
> > >> active domain and their children recursively. 'count' file now only
> > >> shows power state counts for powerdomains.
> > >> 
> > >> This patch also provices a way to do printk dumps from kernel code,
> > >> by calling the pm_dbg_dump_X functions. The plan is to call these
> > >> functions once an error condition is detected, e.g. failed suspend.
> > >
> > > Why don't you replace this all with a userspace tool that deciphers
> > > the registers for you?
> > 
> > This patch isn't deciphering registers, it's just dumping usecounts, and
> > I think that is extremely useful to have in debugfs.
> > 
> > I've already removed all the register dumping from the kernel in the
> > hopes that someone will write a userspace tool for that.
> 
> OK good to hear you're already considering it.

Yes, register dumps are gone, and I am actually one of the persons who
is missing it.

I think there should still be some capability to get register snapshots
from certain points during kernel execution, this is useful for
debugging purposes. I don't know if it would be possible to do a
call_usermodehelper() or something from kernel space just before wfi to
read all (or part of) the PRCM registers, store them somewhere, and then
decipher this data later with another tool. Any comments to this?

-Tero
