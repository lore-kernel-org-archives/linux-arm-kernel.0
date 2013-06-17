From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 17 Jun 2013 17:54:33 -0400
Subject: [PATCH] arm: delete __cpuinit usage from all users
In-Reply-To: <1371503483-2382-1-git-send-email-paul.gortmaker@windriver.com>
References: <1371503483-2382-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <51BF8599.4080701@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-17 05:11 PM, Paul Gortmaker wrote:
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
> 
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
> 
> This removes all the ARM uses of the __cpuinit macros.

This is missing dealing with __CPUINIT in asm files; sorry - I'll resend.

Thanks,
Paul.
--

> 
> [1] https://lkml.org/lkml/2013/5/20/589
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [This was generated against today's linux-next tree ; I'm assuming
>  most/all pending ARM changes are in there currently.]
> 
>  arch/arm/common/mcpm_platsmp.c            |  4 ++--
>  arch/arm/include/asm/arch_timer.h         |  2 +-
>  arch/arm/kernel/hw_breakpoint.c           |  4 ++--
>  arch/arm/kernel/perf_event_cpu.c          |  6 +++---
>  arch/arm/kernel/psci_smp.c                |  3 +--
>  arch/arm/kernel/smp.c                     | 18 +++++++++---------
>  arch/arm/kernel/smp_twd.c                 |  6 +++---
>  arch/arm/lib/delay.c                      |  2 +-
>  arch/arm/mach-exynos/platsmp.c            |  4 ++--
>  arch/arm/mach-highbank/platsmp.c          |  2 +-
>  arch/arm/mach-imx/platsmp.c               |  2 +-
>  arch/arm/mach-msm/platsmp.c               |  6 +++---
>  arch/arm/mach-msm/timer.c                 |  4 ++--
>  arch/arm/mach-mvebu/coherency.c           |  2 +-
>  arch/arm/mach-mvebu/platsmp.c             |  5 ++---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |  2 +-
>  arch/arm/mach-omap2/omap-smp.c            |  4 ++--
>  arch/arm/mach-omap2/omap-wakeupgen.c      |  4 ++--
>  arch/arm/mach-prima2/platsmp.c            |  4 ++--
>  arch/arm/mach-shmobile/smp-emev2.c        |  2 +-
>  arch/arm/mach-shmobile/smp-r8a7779.c      |  2 +-
>  arch/arm/mach-shmobile/smp-sh73a0.c       |  2 +-
>  arch/arm/mach-socfpga/platsmp.c           |  2 +-
>  arch/arm/mach-spear/generic.h             |  2 +-
>  arch/arm/mach-spear/platsmp.c             |  4 ++--
>  arch/arm/mach-tegra/platsmp.c             |  4 ++--
>  arch/arm/mach-tegra/pm.c                  |  2 +-
>  arch/arm/mach-ux500/platsmp.c             |  4 ++--
>  arch/arm/mach-zynq/common.h               |  2 +-
>  arch/arm/mach-zynq/platsmp.c              |  6 +++---
>  arch/arm/plat-versatile/platsmp.c         |  6 +++---
>  31 files changed, 60 insertions(+), 62 deletions(-)
> 
