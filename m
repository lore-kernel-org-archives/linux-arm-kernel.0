From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 13 Mar 2010 14:15:00 +0100
Subject: scary warning in atags.c -- 2.6.34-rc1
In-Reply-To: <20100313103913.GA9812@elf.ucw.cz>
References: <20100313103913.GA9812@elf.ucw.cz>
Message-ID: <201003131415.00156.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 13. b?ezna 2010 11:39:13 Pavel Machek napsal(a):
> Hi!
> 
> Scary warning on HTC Dream:
> 
> [    0.220000] ------------[ cut here ]------------
> [    0.220000] WARNING: at arch/arm/kernel/atags.c:60
> init_atags_procfs+0x5c/0xe8()
> [    0.220000] Modules linked in:
> [    0.220000] [<c0025250>] (unwind_backtrace+0x0/0xdc) from
> [<c0032e1c>] (warn_slowp)
> [    0.220000] [<c0032e1c>] (warn_slowpath_common+0x4c/0x80) from
> [<c000b4b8>] (init_)
> [    0.220000] [<c000b4b8>] (init_atags_procfs+0x5c/0xe8) from
> [<c002033c>] (do_one_i)
> [    0.220000] [<c002033c>] (do_one_initcall+0x5c/0x1bc) from
> [<c0008584>] (kernel_in)
> [    0.220000] [<c0008584>] (kernel_init+0x94/0x148) from [<c00217b4>]
> (kernel_thread)
> [    0.220000] ---[ end trace 1b75b31a2719ed1c ]---
> [    0.230000] bio: create slab <bio-0> at 0
> [    0.230000] Switching to clocksource dg_timer
> 
> Hmm, what are atags anyway?
> 							Pavel
> 
Atags are data passed by the bootloader to kernel (like memory size, machine id 
...).
