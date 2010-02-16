From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 16 Feb 2010 14:00:07 +0300
Subject: [PATCH 12/19] OMAP3 clock: Remove FreqSel for 3630
In-Reply-To: <20100216012453.1101.96664.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
	<20100216012453.1101.96664.stgit@localhost.localdomain>
Message-ID: <4B7A7AB7.90503@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Paul Walmsley wrote:

> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> DPLL_FREQSEL field in CLKEN_PLL register is no longer valid for
> OMAP3630. So remove references to that.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/dpll3xxx.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 2b559fc..84be81c 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -243,8 +243,11 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>  	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
>  	_omap3_noncore_dpll_bypass(clk);
>  
> -	/* Set jitter correction */
> -	if (!cpu_is_omap44xx()) {
> +	/*
> +	 * Set jitter correction. No jitter correction for OMAP4 and 3630
> +	 * since freqsel is field is no longer present
>   

   I can't parse that comment. I guess first "is" is not needed. :-)

WBR, Sergei
