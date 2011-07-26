From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Jul 2011 16:11:40 +0300
Subject: [PATCH V3 01/19] OMAP3: hwmod: add SmartReflex IRQs
In-Reply-To: <1299338962-5602-2-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-2-git-send-email-nm@ti.com>
Message-ID: <20110726131139.GN32582@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 05, 2011 at 08:59:04PM +0530, Nishanth Menon wrote:
> OMAP3 SmartReflex IRQs in hwmod structures with the same naming as
> present in OMAP4. Without these IRQs being registered, SmartReflex
> driver will be unable to get the IRQ numbers to handle notifications
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Acked-by: Felipe Balbi <balbi@ti.com>

According to 36xx TRM page 383, the IRQ numbers are correct.

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 196a834..2d464bc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -378,6 +378,15 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
> +	{.name = "sr1_irq", .irq = 18},
> +};
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
> +	{.name = "sr2_irq", .irq = 19},
> +};
> +
>  /* L4 CORE -> SR1 interface */
>  static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
>  	{
> @@ -2925,6 +2934,8 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
> +	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
>  };
>  
> @@ -2945,6 +2956,8 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
>  	.slaves		= omap3_sr1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  };
>  
>  /* SR2 */
> @@ -2971,6 +2984,8 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
> +	.mpu_irqs	= omap3_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
>  };
>  
> @@ -2991,6 +3006,8 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
>  	.slaves		= omap3_sr2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.mpu_irqs	= omap3_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  };
>  
>  /*
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110726/b8a7a704/attachment-0001.sig>
