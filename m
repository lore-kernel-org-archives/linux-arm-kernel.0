From: david@lechnology.com (David Lechner)
Date: Fri, 11 May 2018 20:01:47 -0500
Subject: [PATCH 1/2] clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always
 enabled
In-Reply-To: <20180511141037.25250-2-nsekhar@ti.com>
References: <20180511141037.25250-1-nsekhar@ti.com>
 <20180511141037.25250-2-nsekhar@ti.com>
Message-ID: <4dd5fe51-a8ec-507b-53c3-7cb17f538d74@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2018 09:10 AM, Sekhar Nori wrote:
> PLL2 SYSCLK1 on DM646x is connected to DDR2 PHY and cannot
> be disabled. Mark it so to prevent unused clock disable
> infrastructure from disabling it.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   drivers/clk/davinci/pll-dm646x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
> index eb96dd72b6b7..5bdf1cb5fda8 100644
> --- a/drivers/clk/davinci/pll-dm646x.c
> +++ b/drivers/clk/davinci/pll-dm646x.c
> @@ -72,7 +72,7 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
>   	.flags = 0,
>   };
>   
> -SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);
>   
>   int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
>   {
> 

Reviewed-by: David Lechner <david@lechnology.com>
