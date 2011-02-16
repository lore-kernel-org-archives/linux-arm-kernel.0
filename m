From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Wed, 16 Feb 2011 14:03:07 +0100
Subject: [PATCH 0/4] ARM: add support for hw-breakpoints [v4]
In-Reply-To: <000001cbcdd1$03a70ed0$0af52c70$@deacon@arm.com>
References: <1278519780-13317-1-git-send-email-will.deacon@arm.com>	<-857909442890734186@unknownmsgid>
	<AANLkTi=u-=BkFP7HfsbYUM5_FnVm+5Vj7kfARXPsNf+e@mail.gmail.com>
	<000001cbcdd1$03a70ed0$0af52c70$@deacon@arm.com>
Message-ID: <OF8E834961.A0F50F0E-ONC1257839.00478470-C1257839.0047B24B@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Will Deacon" <will.deacon@arm.com> wrote on 02/16/2011 12:59:49 PM:

> > There seems to be a bug in the gdb patch... There should probably
> be a separate loop for wpts.
> >
> >       for (i = 0; i < info->bp_count; i++)
> > >    {
> > >      if (arm_hwbp_control_is_enabled (p->bpts[i].control))
> > >        arm_linux_insert_hw_breakpoint1 (p->bpts + i, tid, 0);
> > >      if (arm_hwbp_control_is_enabled (p->wpts[i].control))
> > >        arm_linux_insert_hw_breakpoint1 (p->wpts + i, tid, 1);
> > >    }
>
> Ulrich Weigand (added to CC) is dealing with the GDB patches, so he
> will have more idea about this than me. Last I heard, the testsuite
> was passing so I guess this has been fixed if it was a problem.

Yes, this is indeed a bug (it only occurs sporadically, since its
effect is to access random memory), and it should be fixed by
using two separate loops.

That's one of the changes I've had to make as well.  I'll post an
updated patch set including all the changes required to get a clean
testsuite run shortly ...



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
  IBM Deutschland Research & Development GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch?ftsf?hrung: Dirk
Wittkopp
  Sitz der Gesellschaft: B?blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294
