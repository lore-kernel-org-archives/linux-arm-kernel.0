From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 13:25:22 -0700
Subject: [PATCH v2 05/18] ARM: OMAP5: PM: Enables ES2 PM mode by default
In-Reply-To: <1364205910-32392-6-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:57 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <876203wedp.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Enables MPUSS ES2 power management mode using ES2_PM_MODE in
> AMBA_IF_MODE register.
>
> 0x0: ES1 behavior, CPU cores would enter and exit OFF mode together. Broken

What is broken?

> 0x1: ES2 behavior, CPU cores are allowed to enter/exit OFF mode independently.
>
> The AMBA_IF_MODE register value is stored on SAR RAM and restored by
> ROM code.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-secure.h    |    2 ++
>  arch/arm/mach-omap2/omap-wakeupgen.c |   19 +++++++++++++++++++
>  arch/arm/mach-omap2/omap-wakeupgen.h |    1 +
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> index 0e72917..82b3c4c 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -42,6 +42,8 @@
>  #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
>  #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
>  
> +#define OMAP5_MON_AMBA_IF_INDEX		0x108
> +
>  /* Secure PPA(Primary Protected Application) APIs */
>  #define OMAP4_PPA_L2_POR_INDEX		0x23
>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index f8bb3b9..8bcaa8c 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -42,6 +42,7 @@
>  #define CPU1_ID			0x1
>  #define OMAP4_NR_BANKS		4
>  #define OMAP4_NR_IRQS		128
> +#define OMAP5_AMBA_IF_PM_MODE	(1 << 5)

nit: use BIT()

Kevin
