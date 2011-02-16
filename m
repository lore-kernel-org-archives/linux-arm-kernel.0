From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Feb 2011 11:59:49 -0000
Subject: [PATCH 0/4] ARM: add support for hw-breakpoints [v4]
In-Reply-To: <AANLkTi=u-=BkFP7HfsbYUM5_FnVm+5Vj7kfARXPsNf+e@mail.gmail.com>
References: <1278519780-13317-1-git-send-email-will.deacon@arm.com>	<-857909442890734186@unknownmsgid>
	<AANLkTi=u-=BkFP7HfsbYUM5_FnVm+5Vj7kfARXPsNf+e@mail.gmail.com>
Message-ID: <000001cbcdd1$03a70ed0$0af52c70$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Karthik,

> There seems to be a bug in the gdb patch... There should probably be a separate loop for wpts.
> 
>       for (i = 0; i < info->bp_count; i++)
> > 	{
> > 	  if (arm_hwbp_control_is_enabled (p->bpts[i].control))
> > 	    arm_linux_insert_hw_breakpoint1 (p->bpts + i, tid, 0);
> > 	  if (arm_hwbp_control_is_enabled (p->wpts[i].control))
> > 	    arm_linux_insert_hw_breakpoint1 (p->wpts + i, tid, 1);
> > 	}

Ulrich Weigand (added to CC) is dealing with the GDB patches, so he
will have more idea about this than me. Last I heard, the testsuite
was passing so I guess this has been fixed if it was a problem.

Cheers,

Will
