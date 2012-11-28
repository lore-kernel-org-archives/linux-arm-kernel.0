From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 28 Nov 2012 11:17:21 +0530
Subject: [PATCH 2/3] ARM: OMAP4: Fix build error and warning in timer.c
In-Reply-To: <1354068915-3378-3-git-send-email-jon-hunter@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
 <1354068915-3378-3-git-send-email-jon-hunter@ti.com>
Message-ID: <50B5A569.4000908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 November 2012 07:45 AM, Jon Hunter wrote:
> When compiling the kernel with configuration option CONFIG_ARCH_OMAP4
> enabled and CONFIG_LOCAL_TIMERS disabled, the following build error and
> warning is seen.
>
>    CC      arch/arm/mach-omap2/timer.o
>    arch/arm/mach-omap2/timer.c: In function ?omap4_local_timer_init?:
>    arch/arm/mach-omap2/timer.c:630:2: error: implicit declaration of
>    	function ?omap4_sync32_timer_init?
> 	[-Werror=implicit-function-declaration]
>    arch/arm/mach-omap2/timer.c: At top level:
>    arch/arm/mach-omap2/timer.c:607:1: warning: ?omap4_sync32k_timer_init?
>    	defined but not used [-Wunused-function]
>    cc1: some warnings being treated as errors
>    make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
>
> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remove
> CONFIG_OMAP_32K_TIMER) where the "k" is missing from the "sync32k" in
> the function name "omap4_sync32_timer_init". Therefore, correct this
> typo to resolve the above error and warning.
>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
