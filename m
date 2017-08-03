From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Aug 2017 15:17:20 +0200
Subject: [PATCH 1/2] ARM: mvebu: enable ARM_GLOBAL_TIMER compilation
 Armada 38x platforms
In-Reply-To: <1501605383-24748-2-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Tue, 1 Aug 2017 18:36:22 +0200")
References: <1501605383-24748-1-git-send-email-mw@semihalf.com>
 <1501605383-24748-2-git-send-email-mw@semihalf.com>
Message-ID: <87efss94f3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On mar., ao?t 01 2017, Marcin Wojtas <mw@semihalf.com> wrote:

> Armada 38x SoCs along with legacy timer (time-armada-370-xp.c),
> comprise generic Cortex-A9 global timer (arm_global_timer.c).
> Enable its compilation. The system clocksource subsystem
> will pick one of above two available ones in case the global
> timer node is present in the device tree.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Applied on mvebu/soc

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 541647f..9b49867 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -60,6 +60,8 @@ config MACH_ARMADA_38X
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> +	select ARM_GLOBAL_TIMER
> +	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>  	select ARMADA_370_XP_IRQ
>  	select ARMADA_38X_CLK
>  	select HAVE_ARM_SCU
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
