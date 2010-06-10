From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Jun 2010 10:10:42 +0200
Subject: [PATCH 1/3] mx25: add watchdog clock
In-Reply-To: <bc8385e0c903851918839a66f9e582a507434e93.1276081393.git.baruch@tkos.co.il>
References: <cover.1276081393.git.baruch@tkos.co.il>
	<bc8385e0c903851918839a66f9e582a507434e93.1276081393.git.baruch@tkos.co.il>
Message-ID: <20100610081042.GB5333@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Wed, Jun 09, 2010 at 02:07:00PM +0300, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/mach-mx25/clock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> index 1550149..f9662d9 100644
> --- a/arch/arm/mach-mx25/clock.c
> +++ b/arch/arm/mach-mx25/clock.c
> @@ -191,6 +191,7 @@ DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
>  DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
>  DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
>  DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
> +DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR1, 19, get_rate_ipg, NULL,  NULL);

That is clk_gpt1 according to my RM (Rev 1)?

>  
>  #define _REGISTER_CLOCK(d, n, c)	\
>  	{				\
> @@ -225,6 +226,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
>  	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
> +	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
>  };
>  
>  int __init mx25_clocks_init(void)
> -- 
> 1.7.1
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100610/869bbe0d/attachment.sig>
