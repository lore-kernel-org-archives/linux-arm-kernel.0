From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 9 Jul 2014 15:08:49 +0530
Subject: [PATCH 1/3] arm: dra7xx: Add hwmod data for MDIO and CPSW
In-Reply-To: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <53BD0DA9.5080403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 July 2014 12:10 AM, Sebastian Andrzej Siewior wrote:
> Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC
>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Praveen Rao <prao@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 96 +++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 20b4398..0fa2c66 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1845,6 +1845,85 @@ static struct omap_hwmod dra7xx_vcp2_hwmod = {
>  };
>  
>  /*
> + * 'gmac' class
> + * cpsw/gmac sub system
> + */
> +static struct omap_hwmod_class_sysconfig dra7xx_gmac_sysc = {
> +	.rev_offs	= 0x0,
> +	.sysc_offs	= 0x8,
> +	.syss_offs	= 0x4,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
> +			SYSS_HAS_RESET_STATUS),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | MSTANDBY_FORCE |
> +			MSTANDBY_NO),
> +	.sysc_fields	= &omap_hwmod_sysc_type3,
> +};
> +
> +static struct omap_hwmod_class dra7xx_gmac_hwmod_class = {
> +	.name	= "gmac",
> +	.sysc	= &dra7xx_gmac_sysc,
> +};
> +
> +static struct omap_hwmod_irq_info dra7xx_gmac_irqs[] = {
> +	{ .name = "c0_rx_thresh_pend", .irq = 50 + DRA7XX_IRQ_GIC_START, },
> +	{ .name = "c0_rx_pend", .irq = 51 + DRA7XX_IRQ_GIC_START, },
> +	{ .name = "c0_tx_pend", .irq = 52 + DRA7XX_IRQ_GIC_START, },
> +	{ .name = "c0_misc_pend", .irq = 53 + DRA7XX_IRQ_GIC_START, },
> +	{ .irq = -1 },
> +};

This is not proper, NAK

Hwmod is already posted
http://www.spinics.net/lists/linux-omap/msg99039.html
and waiting for Acks and tested-by

Regards
Mugunthan V N
