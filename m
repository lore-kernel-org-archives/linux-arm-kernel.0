From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 23 Mar 2012 08:59:28 +0530
Subject: [PATCH] ARM: SPEAr600: Change FSMC and SMI clock names
In-Reply-To: <1332420073-17703-1-git-send-email-sr@denx.de>
References: <1332420073-17703-1-git-send-email-sr@denx.de>
Message-ID: <4F6BEE18.1080209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2012 6:11 PM, Stefan Roese wrote:
> Change FSMC and SMI clock names to match the ones needed for DT based
> probing.
> 

please keep spear-devel at list.st.com in cc. :)

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear6xx/clock.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
> index a86499a..f051804 100644
> --- a/arch/arm/mach-spear6xx/clock.c
> +++ b/arch/arm/mach-spear6xx/clock.c
> @@ -660,8 +660,8 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{ .dev_id = "dma",		.clk = &dma_clk},
>  	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
>  	{ .dev_id = "gmac",		.clk = &gmac_clk},
> -	{ .dev_id = "smi",		.clk = &smi_clk},
> -	{ .dev_id = "fsmc-nand",	.clk = &fsmc_clk},
> +	{ .dev_id = "fc000000.flash",	.clk = &smi_clk},
> +	{ .dev_id = "d1800000.flash",	.clk = &fsmc_clk},
>  	/* clock derived from apb clk */
>  	{ .dev_id = "adc",		.clk = &adc_clk},
>  	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},

Acked-by: Viresh Kumar <viresh.kumar@st.com>

@Arnd: I would start to apply these patches on my git tree from now
onwards and will send you pull request later.

-- 
viresh
