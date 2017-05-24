From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 11:45:12 +0200
Subject: [PATCH v2 2/2] clk: gxbb: remove CLK_IGNORE_UNUSED from clk81
In-Reply-To: <20170524093932.5262-3-jbrunet@baylibre.com>
References: <20170524093932.5262-1-jbrunet@baylibre.com>
 <20170524093932.5262-3-jbrunet@baylibre.com>
Message-ID: <b1442c8a-bdfc-01ac-dada-71de43bd060a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2017 11:39 AM, Jerome Brunet wrote:
> clk81 already has CLK_IS_CRITICAL so CLK_IGNORE_UNUSED is not
> necessary
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/gxbb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index ad5f027af1a2..be6350a03074 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -676,7 +676,7 @@ static struct clk_gate gxbb_clk81 = {
>  		.ops = &clk_gate_ops,
>  		.parent_names = (const char *[]){ "mpeg_clk_div" },
>  		.num_parents = 1,
> -		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL),
> +		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
>  	},
>  };
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
