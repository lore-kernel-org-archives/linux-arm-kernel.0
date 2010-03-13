From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Mar 2010 15:06:51 +0000
Subject: scary warning in atags.c -- 2.6.34-rc1
In-Reply-To: <201003131415.00156.marek.vasut@gmail.com>
References: <20100313103913.GA9812@elf.ucw.cz>
	<201003131415.00156.marek.vasut@gmail.com>
Message-ID: <20100313150651.GB4627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 13, 2010 at 02:15:00PM +0100, Marek Vasut wrote:
> Dne So 13. b?ezna 2010 11:39:13 Pavel Machek napsal(a):
> > Hi!
> > 
> > Scary warning on HTC Dream:
> > 
> > [    0.220000] ------------[ cut here ]------------
> > [    0.220000] WARNING: at arch/arm/kernel/atags.c:60
> > init_atags_procfs+0x5c/0xe8()
> > [    0.220000] Modules linked in:
> > [    0.220000] [<c0025250>] (unwind_backtrace+0x0/0xdc) from
> > [<c0032e1c>] (warn_slowp)
> > [    0.220000] [<c0032e1c>] (warn_slowpath_common+0x4c/0x80) from
> > [<c000b4b8>] (init_)
> > [    0.220000] [<c000b4b8>] (init_atags_procfs+0x5c/0xe8) from
> > [<c002033c>] (do_one_i)
> > [    0.220000] [<c002033c>] (do_one_initcall+0x5c/0x1bc) from
> > [<c0008584>] (kernel_in)
> > [    0.220000] [<c0008584>] (kernel_init+0x94/0x148) from [<c00217b4>]
> > (kernel_thread)
> > [    0.220000] ---[ end trace 1b75b31a2719ed1c ]---
> > [    0.230000] bio: create slab <bio-0> at 0
> > [    0.230000] Switching to clocksource dg_timer
> > 
> > Hmm, what are atags anyway?
> > 							Pavel
> > 
> Atags are data passed by the bootloader to kernel (like memory size,
> machine id ...).

Your bootloader is broken - it doesn't terminate the ATAG list correctly.
You'd have thought that getting two values correct would be simple...
