From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 1 Oct 2009 10:42:09 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <20091001101925.50a592fd@marrow.netinsight.se>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<20091001081216.GA4941@twin.sascha.silbe.org>
	<20091001101925.50a592fd@marrow.netinsight.se>
Message-ID: <200910011042.09185.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 01 Oktober 2009 10:19:25 schrieb Simon Kagstrom:
> 
> On Thu, 1 Oct 2009 10:12:16 +0200
> Sascha Silbe <sascha-ml-devel-openrd-google@silbe.org> wrote:
> 
> > On Thu, Oct 01, 2009 at 09:04:18AM +0200, Dieter Kiermaier wrote:
> > 
> > > WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
> > > Modules linked in:
> > > [<c002a748>] (unwind_backtrace+0x0/0xd8) from [<c003931c>] 
> > > (warn_slowpath_common+0x4c/0x68)
> > > [<c003931c>] (warn_slowpath_common+0x4c/0x68) from [<c0026844>] 
> > > (cpu_idle+0x74/0xbc)
> > > [<c0026844>] (cpu_idle+0x74/0xbc) from [<c0008b2c>] 
> > > (start_kernel+0x22c/0x27c)
> > > [<c0008b2c>] (start_kernel+0x22c/0x27c) from [<00008034>] (0x8034)
> > Try the patch from [1], it works for me (uptime 5 days now without the 
> > message above).
> > Disclaimer: I know next to nothing about Linux internals, so can't judge 
> > the quality of the patch. Use at your own risk.
> > 
> > [1] http://patchwork.kernel.org/patch/40871/
> 
> Nice!
> 
> I should add that I've seen this error even without openocd connected,
> so this seems to be a real error. Anyway, I guess this will sooner or
> later be applied (in some form) upstream, so openrd should benefit
> "automatically" from it.
> 
> However, with OpenOCD there are other type of crashes which look very
> random, so I believe those will stay even with this.
> 

Many thanks to all off you for your valuable comments!

As far as I've seen on my system there are two different things in conjunction with openOCD:

1. The above adressed issue in cpu_idle path
2. Another different thing which causes slightly random crashes.

So [1.] could be solved by the above mentioned patch - I will try this out.

[2.] ??? I will try to find some information at the openocd list archive...

Dieter


> // Simon
> 
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to the Google Groups "OpenRD" group.
> To post to this group, send email to openrd at googlegroups.com
> To unsubscribe from this group, send email to openrd+unsubscribe at googlegroups.com
> For more options, visit this group at http://groups.google.com/group/openrd?hl=en
> -~----------~----~----~----~------~----~------~--~---
> 
