From: david@lechnology.com (David Lechner)
Date: Tue, 15 May 2018 10:36:31 -0500
Subject: [PATCH v2 1/2] clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always
 enabled
In-Reply-To: <20180515112224.30122-2-nsekhar@ti.com>
References: <20180515112224.30122-1-nsekhar@ti.com>
 <20180515112224.30122-2-nsekhar@ti.com>
Message-ID: <3f023a9b-f976-4ee7-59bf-7653e7b56ded@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2018 06:22 AM, Sekhar Nori wrote:
> PLL2 SYSCLK1 on DM646x is connected to DDR2 PHY and cannot
> be disabled. Mark it so to prevent unused clock disable
> infrastructure from disabling it.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v2: rebased to apply to v4.17-rc1. No functional change.
> 
>   drivers/clk/davinci/pll-dm646x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
> index a61cc3256418..0ae827e3ce80 100644
> --- a/drivers/clk/davinci/pll-dm646x.c
> +++ b/drivers/clk/davinci/pll-dm646x.c
> @@ -72,7 +72,7 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
>   	.flags = 0,
>   };
>   
> -SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);
>   
>   int dm646x_pll2_init(struct device *dev, void __iomem *base)
>   {
> 

Reviewed-by: David Lechner <david@lechnology.com>
