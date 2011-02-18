From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 18 Feb 2011 23:41:34 +0530
Subject: [PATCH 2/5] omap4: Enable ARM local timers with OMAP4430 es1.0
	exception
In-Reply-To: <1297510187-31547-3-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <33e02589041f47e8df8bdc7d97a631f1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Saturday, February 12, 2011 5:00 PM
> To: linux-omap at vger.kernel.org
> Cc: khilman at ti.com; linux-arm-kernel at lists.infradead.org;
> tony at atomide.com; Santosh Shilimkar
> Subject: [PATCH 2/5] omap4: Enable ARM local timers with OMAP4430
> es1.0 exception
>
[....]

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-
> omap2/Kconfig
> index 1a2cf62..f285dd7 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -44,6 +44,7 @@ config ARCH_OMAP4
>  	depends on ARCH_OMAP2PLUS
>  	select CPU_V7
>  	select ARM_GIC
> +	select LOCAL_TIMERS
This change should be 'select LOCAL_TIMERS if SMP'

Otherwise, with !SMP, the build will break.
Here is the updated version with Tony's ack added.

--------
