From: trimarchi@gandalf.sssup.it (Michael Trimarchi)
Date: Tue, 15 Mar 2011 19:46:38 +0100
Subject: [PATCH 2/2] i.MX25:  add sdma clock definitions
In-Reply-To: <1298638155-4128-2-git-send-email-eric@eukrea.com>
References: <1298638155-4128-1-git-send-email-eric@eukrea.com>
	<1298638155-4128-2-git-send-email-eric@eukrea.com>
Message-ID: <4D7FB40E.8030006@gandalf.sssup.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I have done the same yesterday

On 02/25/2011 01:49 PM, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-imx/clock-imx25.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
> index daa0165..a65838f 100644
> --- a/arch/arm/mach-imx/clock-imx25.c
> +++ b/arch/arm/mach-imx/clock-imx25.c
> @@ -228,6 +228,7 @@ DEFINE_CLOCK(esdhc1_per_clk, 0, CCM_CGCR0,  3, get_rate_esdhc1,	 NULL,
>  DEFINE_CLOCK(esdhc2_ahb_clk, 0, CCM_CGCR0, 22, get_rate_esdhc2,	 NULL, NULL);
>  DEFINE_CLOCK(esdhc2_per_clk, 0, CCM_CGCR0,  4, get_rate_esdhc2,	 NULL,
>  		&esdhc2_ahb_clk);
> +DEFINE_CLOCK(sdma_ahb_clk, 0, CCM_CGCR0, 26, NULL,	 NULL, NULL);
>  DEFINE_CLOCK(fec_ahb_clk, 0, CCM_CGCR0, 23, NULL,	 NULL, NULL);
>  DEFINE_CLOCK(lcdc_ahb_clk, 0, CCM_CGCR0, 24, NULL,	 NULL, NULL);
>  DEFINE_CLOCK(lcdc_per_clk, 0, CCM_CGCR0,  7, NULL,	 NULL, &lcdc_ahb_clk);
> @@ -253,6 +254,7 @@ DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
>  DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR2, 19, get_rate_ipg, NULL,  NULL);
>  DEFINE_CLOCK(ssi1_clk,  0, CCM_CGCR2, 11, get_rate_ssi1, NULL, &ssi1_per_clk);
>  DEFINE_CLOCK(ssi2_clk,  1, CCM_CGCR2, 12, get_rate_ssi2, NULL, &ssi2_per_clk);
> +DEFINE_CLOCK(sdma_clk, 0, CCM_CGCR2,  6, get_rate_ipg, NULL, &sdma_ahb_clk);
>  DEFINE_CLOCK(esdhc1_clk,  0, CCM_CGCR1, 13, get_rate_esdhc1, NULL,
>  		&esdhc1_per_clk);
>  DEFINE_CLOCK(esdhc2_clk,  1, CCM_CGCR1, 14, get_rate_esdhc2, NULL,
> @@ -304,6 +306,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
>  	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
>  	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
> +	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
>  };
>  
>  int __init mx25_clocks_init(void)


 struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
-       imx_imx_sdma_data_entry_single(MX25, 1, "imx25", 0);
+       imx_imx_sdma_data_entry_single(MX25, 1, "imx25", 1);
 #endif /* ifdef CONFIG_SOC_IMX25 */

But in order to load a build in kernel there is some problem with the _to_version
composition.

Michael Trimarchi
