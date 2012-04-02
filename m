From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Apr 2012 14:08:10 -0700
Subject: [PATCH 1/6] ARM: S3C24XX: Add forgotten clock lookup table to
 S3C2443
In-Reply-To: <201203122000.31216.heiko@sntech.de>
References: <201203121959.32966.heiko@sntech.de>
 <201203122000.31216.heiko@sntech.de>
Message-ID: <4F7A153A.5070701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> When the hsmmc clock lookup was changed to be lookup tables based,
> it seems the S3C2443 was forgotten.
>
> As subsequent patches will want to add more lookups to it, this
> patch adds the base table with the missing hsmmc lookup.
>
> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> ---
>   arch/arm/mach-s3c24xx/clock-s3c2443.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
> index efb3ac3..bce1cd3 100644
> --- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
> +++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
> @@ -179,6 +179,10 @@ static struct clk *clks[] __initdata = {
>   	&clk_hsmmc,
>   };
>
> +static struct clk_lookup s3c2443_clk_lookup[] = {
> +	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2",&clk_hsmmc),
> +};
> +
>   void __init s3c2443_init_clocks(int xtal)
>   {
>   	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
> @@ -210,6 +214,7 @@ void __init s3c2443_init_clocks(int xtal)
>
>   	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
>   	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
> +	clkdev_add_table(s3c2443_clk_lookup, ARRAY_SIZE(s3c2443_clk_lookup));
>
>   	s3c_pwmclk_init();
>   }

Uhm..how about mach-s3c24xx/common-s3c2443.c?

I think, we need to sort out some files in mach-s3c24xx/ and some 
remained mach-s3c24.. directories, actually, as you know, we didn't have 
much time to do it last time :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
