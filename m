From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Oct 2015 12:38:15 -0700
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <56138485.4090600@free.fr>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <56138485.4090600@free.fr>
Message-ID: <20151006193815.GI12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06, Mason wrote:
> On 02/10/2015 20:02, Stephen Boyd wrote:
> 
> > The warning has been removed in commit 5028090d1da1 (ARM: 8434/1:
> > Revert "7655/1: smp_twd: make twd_local_timer_of_register() no-op
> > for nosmp", 2015-09-14) sitting in linux-next. Oddly, that commit
> > doesn't remove the depends on SMP for the Kconfig. So it seems
> > that we can apply this patch and everyone is happy? We could also
> > drop the "if SMP" part of most of the platform selects if anyone
> > actually cares.
> > 
> > ---8<----
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 369791fb619c..be64d9d604c3 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1389,7 +1389,6 @@ config HAVE_ARM_ARCH_TIMER
> >  
> >  config HAVE_ARM_TWD
> >  	bool
> > -	depends on SMP
> >  	select CLKSRC_OF if OF
> >  	help
> >  	  This options enables support for the ARM timer and watchdog unit
> 
> Hello Stephen,
> 
> Should I make a formal submission for the above patch to be accepted?

No. I believe Felipe is going to update commit 5028090d1da1 to
remove the depends on.

> 
> (Did you see my "twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally"
> patch? What should I do now for it to be accepted?)
> 

Assuming you sent it to the correct maintainer from the
MAINTAINERS file, I would expect them to apply it directly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
