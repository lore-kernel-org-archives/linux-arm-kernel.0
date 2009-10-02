From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Fri, 2 Oct 2009 08:53:50 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <20091002084000.7c93d634@marrow.netinsight.se>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<alpine.LFD.2.00.0910011218410.4997@xanadu.home>
	<20091002084000.7c93d634@marrow.netinsight.se>
Message-ID: <200910020853.50439.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag 02 Oktober 2009 08:40:00 schrieb Simon Kagstrom:
> 
> On Thu, 01 Oct 2009 12:19:21 -0400 (EDT)
> Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > > I should add that I've seen this error even without openocd connected,
> > > so this seems to be a real error. Anyway, I guess this will sooner or
> > > later be applied (in some form) upstream, so openrd should benefit
> > > "automatically" from it.
> > > 
> > > However, with OpenOCD there are other type of crashes which look very
> > > random, so I believe those will stay even with this.
> > 
> > Please send me information about those when you can.
> 
> The nohlt argument seems to fix them, thanks! Without it I get random
> memory corruption errors such as this:
>

This is exactly what I've seen on my desk - with nohlt everything is running fine all the time!
Many thanks to the experts :)

Dieter

 
>    Mount local file[    5.160903] BUG: spinlock wrong owner on CPU#0, rc.sysinit/452
>    [    5.166878]  lock: df464af8, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: 0
>    [    5.174229] [<c003130c>] (unwind_backtrace+0x0/0xdc) from [<c02c7b10>] (dump_stack+0x18/0x1c)
>    [    5.182842] [<c02c7b10>] (dump_stack+0x18/0x1c) from [<c017bc08>] (spin_bug+0x90/0xa4)
>    [    5.190837] [<c017bc08>] (spin_bug+0x90/0xa4) from [<c017bc84>] (_raw_spin_unlock+0x68/0xac)
>    [    5.199356] [<c017bc84>] (_raw_spin_unlock+0x68/0xac) from [<c02ca8a0>] (_spin_unlock_irq+0x10/0x20)
>    [    5.208573] [<c02ca8a0>] (_spin_unlock_irq+0x10/0x20) from [<c00475dc>] (dup_mm+0x278/0x450)
>    [    5.217093] [<c00475dc>] (dup_mm+0x278/0x450) from [<c0048004>] (copy_process+0x794/0xddc)
>    [    5.225437] [<c0048004>] (copy_process+0x794/0xddc) from [<c00487ac>] (do_fork+0x160/0x314)
>    [    5.233870] [<c00487ac>] (do_fork+0x160/0x314) from [<c002e218>] (sys_clone+0x34/0x3c)
>    [    5.241867] [<c002e218>] (sys_clone+0x34/0x3c) from [<c002ae80>] (ret_fast_syscall+0x0/0x28)
>    systems.
>    Segmentation fault
>    [    5.264718] Slab corruption: names_cache start=df9f9000, len=4096
> 
> although the typical case is that it just hangs without printing out
> much.
> 
> // Simon
> 
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to the Google Groups "OpenRD" group.
> To post to this group, send email to openrd at googlegroups.com
> To unsubscribe from this group, send email to openrd+unsubscribe at googlegroups.com
> For more options, visit this group at http://groups.google.com/group/openrd?hl=en
> -~----------~----~----~----~------~----~------~--~---
> 
