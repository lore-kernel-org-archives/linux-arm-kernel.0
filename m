From: informkarthik@gmail.com (karthikeyan.s)
Date: Wed, 16 Feb 2011 16:59:36 +0530
Subject: [PATCH 0/4] ARM: add support for hw-breakpoints [v4]
In-Reply-To: <-857909442890734186@unknownmsgid>
References: <1278519780-13317-1-git-send-email-will.deacon@arm.com>
	<-857909442890734186@unknownmsgid>
Message-ID: <AANLkTi=u-=BkFP7HfsbYUM5_FnVm+5Vj7kfARXPsNf+e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There seems to be a bug in the gdb patch... There should probably be a
separate loop for wpts.

      for (i = 0; i < info->bp_count; i++)
> 	{
> 	  if (arm_hwbp_control_is_enabled (p->bpts[i].control))
> 	    arm_linux_insert_hw_breakpoint1 (p->bpts + i, tid, 0);
> 	  if (arm_hwbp_control_is_enabled (p->wpts[i].control))
> 	    arm_linux_insert_hw_breakpoint1 (p->wpts + i, tid, 1);
> 	}


-Karthik

On Wed, Jul 7, 2010 at 10:02 PM, Will Deacon <will.deacon@arm.com> wrote:

> Hello,
>
> > This is version 4 of the patches originally posted at:
> >
> > v1.)
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html
> > v2.)
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011170.html
> > v3.)
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017680.html
> >
> > Changes from v3 include:
> >       - Based on 2.6.35-rc3
> >       - Support for unaligned addresses
> >       - Numerous bug fixes
> >       - Tested with GDB, for which the testsuite passes
> >
> > GDB patches have been posted here:
> >
> > http://sourceware.org/ml/gdb-patches/2010-07/msg00110.html
> >
> > I'd like to get these patches applied now that I'm confident that
> > they function correctly, so please give them a go.
> >
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: S. Karthikeyan <informkarthik@gmail.com>
> > Cc: Matthew Gretton-Dann <matthew.gretton-dann@arm.com>
> >
>
> I accidentally passed suppress-cc=all to git send-email, so this
> is a pointer for the people I meant to CC. If you want to view
> the patchset it's archived at:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019882.html
>
> Sorry about that,
>
> Will
>
>
>


-- 
---
S. Karthikeyan | +919980814745
---
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110216/8ec27222/attachment-0001.html>
