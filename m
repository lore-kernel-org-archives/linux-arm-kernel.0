From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Feb 2012 16:28:04 -0800
Subject: [PATCH 5/6] ARM: OMAP4: suspend: Do not get dsp/tesla out of reset
In-Reply-To: <1330003320-17400-6-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Thu, 23 Feb 2012 15:21:59 +0200")
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-6-git-send-email-t-kristo@ti.com>
Message-ID: <87ehtfssx7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> With no driver handling DSP/TESLA, if brought out of reset, it stays
> active and does not assert standby.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Subject says 'OMAP4: suspend'.  How does HWMOD_INIT_NO_RESET affect
suspend?

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index ef0524c..81d90da 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1160,6 +1160,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
>  	.name		= "dsp",
>  	.class		= &omap44xx_dsp_hwmod_class,
>  	.clkdm_name	= "tesla_clkdm",
> +	.flags		= HWMOD_INIT_NO_RESET,
>  	.mpu_irqs	= omap44xx_dsp_irqs,
>  	.rst_lines	= omap44xx_dsp_resets,
>  	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
