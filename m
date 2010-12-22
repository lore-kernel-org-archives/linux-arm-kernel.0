From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Dec 2010 23:23:58 -0800
Subject: [PATCH 33/40] ARM: tegra: convert sched_clock() to use new
	infrastructure
In-Reply-To: <E1PTYoY-0006jm-UT@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYoY-0006jm-UT@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTimMrHtEGYX=7AHQUNCdxU8xNEbfFP5he5kth8F_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 17, 2010 at 3:49 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Convert tegra to use the new sched_clock() infrastructure for extending
> 32bit counters to full 64-bit nanoseconds.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/Kconfig ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-tegra/timer.c | ? 22 ++++++++++++++++++++--
> ?2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0e1a966..ec7b027 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -570,6 +570,7 @@ config ARCH_TEGRA
> ? ? ? ?select GENERIC_CLOCKEVENTS
> ? ? ? ?select GENERIC_GPIO
> ? ? ? ?select HAVE_CLK
> + ? ? ? select HAVE_SCHED_CLOCK
> ? ? ? ?select COMMON_CLKDEV
> ? ? ? ?select ARCH_HAS_BARRIERS if CACHE_L2X0
> ? ? ? ?select ARCH_HAS_CPUFREQ
> diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
> index c52bd84..b5f86dd 100644
> --- a/arch/arm/mach-tegra/timer.c
> +++ b/arch/arm/mach-tegra/timer.c
> @@ -26,7 +26,6 @@
> ?#include <linux/clocksource.h>
> ?#include <linux/clk.h>
> ?#include <linux/io.h>
> -#include <linux/cnt32_to_63.h>
>
> ?#include <asm/mach/time.h>
> ?#include <asm/localtimer.h>


This needs:

#include <asm/sched_clock.h>

(for DEFINE_CLOCK_DATA and other declarations)


-Olof
