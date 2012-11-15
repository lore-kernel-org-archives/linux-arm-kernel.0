From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Nov 2012 09:43:12 -0800
Subject: [arm-soc:for-next 24/32]
 arch/arm/mach-omap2/board-generic.c:115:13: error: 'omap_prcm_restart'
 undeclared here (not in a function)
In-Reply-To: <50a52344.hTPnPrYFuOqQEPAJ%fengguang.wu@intel.com>
References: <50a52344.hTPnPrYFuOqQEPAJ%fengguang.wu@intel.com>
Message-ID: <20121115174312.GK6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* kbuild test robot <fengguang.wu@intel.com> [121115 09:21]:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
> head:   85f1e7156cfb396d46327b9e6cdf4dbf576f3bcc
> commit: 3b7b5ae34c4604e6a1e0724fc8bd60e44f07e1ef [24/32] Merge branch 'next/dt' into for-next
> config: make ARCH=arm omap2plus_defconfig
> 
> Note: the arm-soc/for-next HEAD 85f1e71 builds fine.
>       It only hurts bisectibility.
> 
> All error/warnings:
> 
> arch/arm/mach-omap2/board-generic.c:115:13: error: 'omap_prcm_restart' undeclared here (not in a function)
> 
> vim +115 +/omap_prcm_restart arch/arm/mach-omap2/board-generic.c
> 
> 7dd9d502 Jon Hunter     2012-09-12  109  	.init_early	= omap3430_init_early,
> 7dd9d502 Jon Hunter     2012-09-12  110  	.init_irq	= omap_intc_of_init,
> 7dd9d502 Jon Hunter     2012-09-12  111  	.handle_irq	= omap3_intc_handle_irq,
> 7dd9d502 Jon Hunter     2012-09-12  112  	.init_machine	= omap_generic_init,
> 7dd9d502 Jon Hunter     2012-09-12  113  	.timer		= &omap3_secure_timer,
> 7dd9d502 Jon Hunter     2012-09-12  114  	.dt_compat	= omap3_gp_boards_compat,
> 7dd9d502 Jon Hunter     2012-09-12 @115  	.restart	= omap_prcm_restart,
> 7dd9d502 Jon Hunter     2012-09-12  116  MACHINE_END
> 8d61649d Benoit Cousson 2011-09-20  117  #endif
> 8d61649d Benoit Cousson 2011-09-20  118  

Thanks I've posted a fix for that. The solution is to use
omap3xxx_restart there.

Regards,

Tony
