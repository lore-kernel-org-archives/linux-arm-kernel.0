From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 05 Jul 2011 09:49:46 -0700
Subject: [PATCH] ARM: omap4: rename gpmc clock to gpmc_ick
In-Reply-To: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>
References: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>
Message-ID: <4E1340AA.2020007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Benoit

On 7/5/2011 5:19 AM, Jan Weitzel wrote:
> The gpmc clock on omap44xx is called gpmc_ick not gpmc_ck in
> clock44xx_data.c
>
> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
This happened after renaming the clock-nodes some time back.
Looks good to me as a fix though in long run GPMC should be
moved to hwmod to avoid such naming issues

> ---
>   arch/arm/mach-omap2/gpmc.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 130034b..34bcd17 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -708,7 +708,7 @@ static int __init gpmc_init(void)
>   		l = OMAP34XX_GPMC_BASE;
>   		gpmc_irq = INT_34XX_GPMC_IRQ;
>   	} else if (cpu_is_omap44xx()) {
> -		ck = "gpmc_ck";
> +		ck = "gpmc_ick";
>   		l = OMAP44XX_GPMC_BASE;
>   		gpmc_irq = OMAP44XX_IRQ_GPMC;
>   	}
