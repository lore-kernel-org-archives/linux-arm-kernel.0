From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Oct 2010 16:43:02 +0900
Subject: [PATCH] ARM: S5PC100: Debug clock sources
In-Reply-To: <1287470544-26462-1-git-send-email-jassisinghbrar@gmail.com>
References: <1287470544-26462-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <05c601cb702a$6ed87d10$4c897730$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Audio, Keypad and ADC inherit PCLKD1 clock source.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s5pc100/clock.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> index be14d4e..8958bde 100644
> --- a/arch/arm/mach-s5pc100/clock.c
> +++ b/arch/arm/mach-s5pc100/clock.c
> @@ -679,55 +679,55 @@ static struct clk init_clocks_disable[] = {
>  	}, {
>  		.name		= "iis",
>  		.id		= 0,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 0),
>  	}, {
>  		.name		= "iis",
>  		.id		= 1,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 1),
>  	}, {
>  		.name		= "iis",
>  		.id		= 2,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 2),
>  	}, {
>  		.name		= "ac97",
>  		.id		= -1,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 3),
>  	}, {
>  		.name		= "pcm",
>  		.id		= 0,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 4),
>  	}, {
>  		.name		= "pcm",
>  		.id		= 1,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 5),
>  	}, {
>  		.name		= "spdif",
>  		.id		= -1,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 6),
>  	}, {
>  		.name		= "adc",
>  		.id		= -1,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 7),
>  	}, {
>  		.name		= "keypad",
>  		.id		= -1,
> -		.parent		= &clk_div_d1_bus.clk,
> +		.parent		= &clk_div_pclkd1.clk,
>  		.enable		= s5pc100_d1_5_ctrl,
>  		.ctrlbit	= (1 << 8),
>  	}, {
> --

Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
