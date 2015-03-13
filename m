From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 11:05:53 +0100
Subject: [PATCH v2.0 0/6] ARM: AT91: pm improvement for 4.1
In-Reply-To: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
References: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5502B681.6010501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/03/2015 04:47, Wenyou Yang a ?crit :
> Hi,
> 
> The patch series purpose is to improve the AT91 pm code.
> 	Create a procedure to handle the sdram self-fresh mode.
> 	The standby mode uses same sram function as the suspend to memory mode,
> 
> It is based on the branch, at91-4.0-fixes
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> 	+ [PATCH] ARM: AT91: pm cleanup for 4.1
> 
> Chang log for v2.0
>  - reserve the at91_xxx_standby() for at91_cpuidle_device.
>  - rebase
> 
> Wenyou Yang (6):
>   pm: at91: pm_slowclock: create the procedure to handle the sdram
>     self-refresh
>   pm: at91: move the copying the sram function to the sram
>     initializationi phase
>   pm: at91: standby mode uses the same sram function as suspend to
>     memory mode
>   pm: at91: rename file name: pm_slowclock.S -->pm_suspend.S
>   pm: at91: rename function name:
>     at91_slow_clock()-->at91_pm_suspend_sram_fn
>   pm: at91: remove unused void (*at91_pm_standby)(void)

Whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-4.1-cleanup

Thanks.

BTW, I had to rework the commit subject as all AT91 patches must begin
with: "ARM: at91". So I reworked them as "ARM: at91/pm:"

Bye,

>  arch/arm/mach-at91/Makefile       |    2 +-
>  arch/arm/mach-at91/pm.c           |  121 +++++++------
>  arch/arm/mach-at91/pm.h           |   10 ++
>  arch/arm/mach-at91/pm_slowclock.S |  296 -------------------------------
>  arch/arm/mach-at91/pm_suspend.S   |  349 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 420 insertions(+), 358 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/pm_slowclock.S
>  create mode 100644 arch/arm/mach-at91/pm_suspend.S
> 


-- 
Nicolas Ferre
