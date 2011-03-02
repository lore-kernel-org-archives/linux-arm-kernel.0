From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 Mar 2011 14:36:18 -0800
Subject: [PATCH 10/17] omap4: pm: Add L2 cache lowpower support
In-Reply-To: <1298112158-28469-11-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:31 +0530")
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-11-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <878vwx40bh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
> necessary maintenance operations and context restoration in the
> low power code.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/omap4-mpuss-lowpower.c |   11 +++++
>  arch/arm/mach-omap2/omap4-sar-layout.h     |    2 +
>  arch/arm/mach-omap2/sleep44xx.S            |   64 ++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> index a30f19b..bff768f 100644
> --- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> @@ -49,6 +49,7 @@
>  #include <asm/system.h>
>  #include <asm/irq.h>
>  #include <asm/hardware/gic.h>
> +#include <asm/hardware/cache-l2x0.h>
>  
>  #include <plat/omap44xx.h>
>  #include <mach/omap4-common.h>
> @@ -341,6 +342,7 @@ int __init omap4_mpuss_init(void)
>  {
>  	struct omap4_cpu_pm_info *pm_info;
>  	u8 i;
> +	u32 val;

This will cause an 'unused variable' compiler warning when
!CONFIG_CACHE_L2X0

[...]

Kevin
