From: tony@atomide.com (Tony Lindgren)
Date: Sat, 22 Sep 2012 08:44:45 -0700
Subject: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
In-Reply-To: <alpine.DEB.2.00.1209220442010.16893@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
 <20120921205322.GK28835@atomide.com>
 <20120921231039.GN28835@atomide.com>
 <alpine.DEB.2.00.1209220442010.16893@utopia.booyaka.com>
Message-ID: <20120922154444.GQ28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120921 22:41]:
> 
> On Fri, 21 Sep 2012, Tony Lindgren wrote:
> 
> > * Tony Lindgren <tony@atomide.com> [120921 13:55]:
> > 
> > Care to base this on something more mergeable? Maybe a merge
> > of cleanup-fixes-for-v3.7 + omap-devel-am33xx-for-v3.7?
> 
> While working on this, noticed that the 4430ES2 Panda test boot failed on 
> the merge base of cleanup-fixes-for-v3.7 and omap-devel-am33xx-for-v3.7.  
> Enabling DEBUG_LL and adding some debug revealed that the static variable 
> 'arch_clkdm' in mach-omap2/clockdomain.c was getting overwritten between 
> omap44xx_clockdomains_init() and the end of IRQ setup.  This was bisected 
> down to this commit:
> 
> commit ec2c0825ca3183a646a24717966cc7752e8b0393
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Mon Aug 27 17:43:01 2012 -0700
> 
>     ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ
>     
>     Remove hardcoded IRQs in irqs.h and related files as these
>     are no longer needed.
>     
> ...
> 
> Looks to me like something is wrong with the IRQ allocation and it's 
> corrupting memory.

Yeah I bet that's e534e871 (ARM: OMAP4: Fix array size for irq_target_cpu)
already in mainline since -rc6.

Regards,

Tony
