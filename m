From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Jan 2013 17:20:21 +0530
Subject: [PATCH v4 8/9] ARM: davinci: da850: Added dsp clock definition,
 keyed to "davinci-rproc.0"
In-Reply-To: <1355967254-16726-9-git-send-email-rtivy@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
 <1355967254-16726-9-git-send-email-rtivy@ti.com>
Message-ID: <50E6C1FD.30405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 7:04 AM, Robert Tivy wrote:
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
>  arch/arm/mach-davinci/da850.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 31ff65a..afc814f 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -369,6 +369,15 @@ static struct clk sata_clk = {
>  	.flags		= PSC_FORCE,
>  };
>  
> +static struct clk dsp_clk = {
> +	.name		= "dsp",
> +	.parent		= &pll0_sysclk1,
> +	.domain		= DAVINCI_GPSC_DSPDOMAIN,
> +	.lpsc		= DA8XX_LPSC0_GEM,
> +	.flags		= PSC_LRST,
> +	.reset		= davinci_clk_reset,

Instead of each clock node initializing the reset function, this can be
once in davinci_clk_init() whenever PSC_LRST is set in flags.

Thanks,
Sekhar
