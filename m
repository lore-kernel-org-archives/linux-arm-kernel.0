From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 14 Feb 2011 16:00:57 +0100
Subject: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
In-Reply-To: <1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
Message-ID: <4D5943A9.8010205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

I found one minor change wrt to the original that I'd like to understand 
better.

On 2/2/2011 8:27 PM, Ramirez Luna, Omar wrote:
> From: Benoit Cousson<b-cousson@ti.com>
>
> Mailbox hwmod data for omap4.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 ++++++++++++++++++++++++++++
>   1 files changed, 67 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index c2806bd..c495669 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2001,6 +2001,70 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/*
> + * 'mailbox' class
> + * mailbox module allowing communication between the on-chip processors
> + * using a queued mailbox-interrupt mechanism.
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_mailbox_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	=&omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
> +	.name = "mailbox",
> +	.sysc =&omap44xx_mailbox_sysc,
> +};
> +
> +/* mailbox */
> +static struct omap_hwmod omap44xx_mailbox_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
> +	{ .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },

The original entry was unnamed since it is an unique entry and thus does 
not need to be differentiate on this platform.

	{ .irq = 26 + OMAP44XX_IRQ_GIC_START },

Do you really need to have a name here? The strategy being to provide a 
name only if more than one entry exist.
It is perfectibility doable, I'm just trying to understand your rational.

Thanks,
Benoit
