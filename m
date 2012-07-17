From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Jul 2012 13:59:01 -0600 (MDT)
Subject: [PATCH-V2 4/4] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
In-Reply-To: <1338285402-11306-5-git-send-email-hvaibhav@ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
 <1338285402-11306-5-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1207171353190.28834@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav

a comment.

On Tue, 29 May 2012, Vaibhav Hiremath wrote:

> This patch adds HWMOD data for all the peripherals of
> AM335X device and also hooks up to the existing OMAP framework.


...

> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> new file mode 100644
> index 0000000..df888fe
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -0,0 +1,3368 @@

...

> +static struct omap_hwmod_irq_info am33xx_emif_irqs[] = {
> +	{ .name = "ddrerr0", .irq = 101 },
> +	{ .irq = -1 }
> +};

So the above array of struct omap_hwmod_irq_info records has a terminator 
(which is correct), but many similar arrays do not, such as:

> +/* l3_main (l3_fast) */
> +static struct omap_hwmod_irq_info am33xx_l3_main_irqs[] = {
> +	{ .name = "l3debug", .irq = 9 },
> +	{ .name = "l3appint", .irq = 10 },
> +};

and

> +static struct omap_hwmod_irq_info am33xx_mpu_irqs[] = {
> +	{ .name = "emuint", .irq = 0 },
> +	{ .name = "commtx", .irq = 1 },
> +	{ .name = "commrx", .irq = 2 },
> +	{ .name = "bench", .irq = 3 },
> +};

and

> +static struct omap_hwmod_rst_info am33xx_wkup_m3_resets[] = {
> +	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
> +};
> +
> +static struct omap_hwmod_irq_info am33xx_wkup_m3_irqs[] = {
> +	{ .name = "txev", .irq = 78 },
> +};

and several others.  

Could you add those, please?

The omap_hwmod_dma_info arrays look clean to me.


- Paul
