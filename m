From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jan 2011 13:16:45 +0200
Subject: [PATCH] omap2: fix DPLL_FREQSEL calculation
In-Reply-To: <87ei8726wf.fsf@vostro.fn.ogness.net>
References: <87ei8726wf.fsf@vostro.fn.ogness.net>
Message-ID: <20110120111645.GB2223@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 20, 2011 at 11:42:24AM +0100, John Ogness wrote:
> This patch fixes the calculation of the internal frequency. The value
> of "n" is one less than the actual divider. 0 is a valid value.
> 
> An example where the internal frequency is calculated correctly can be
> found here: clkt_dpll.c:_dpll_test_fint()
> 
> This patch is against linux-next-20110120.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

scripts/get_maintainer.pl would've helped you getting a better Cc list.
I'm adding linux-omap and lakml

> ---
>  arch/arm/mach-omap2/dpll3xxx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/arm/mach-omap2/dpll3xxx.c	2011-01-20 11:20:41.706860086 +0100
> +++ b/arch/arm/mach-omap2/dpll3xxx.c	2011-01-20 11:21:27.966860086 +0100
> @@ -93,7 +93,7 @@ static u16 _omap3_dpll_compute_freqsel(s
>  	unsigned long fint;
>  	u16 f = 0;
>  
> -	fint = clk->dpll_data->clk_ref->rate / n;
> +	fint = clk->dpll_data->clk_ref->rate / (n + 1);
>  
>  	pr_debug("clock: fint is %lu\n", fint);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
