From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Nov 2018 10:16:04 +0100
Subject: [RFC v1 4/7] clk: meson: clk-pll: add the is_enabled function
 in the clk_ops
In-Reply-To: <20181114225725.2821-5-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
 <20181114225725.2821-5-martin.blumenstingl@googlemail.com>
Message-ID: <3741d17870e51342e7251118f73845667c0f7e14.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> Now that we have a utility function to check whether the PLL is enabled
> we can also pass that to our clk_ops to let the common clock framework
> know about the status of the hardware clock.
> For now this is of limited use since the only common clock framework's

Still, it is nice to have ;)

> internal "disabled unused clocks" mechanism checks for this. Everything
> else still uses the ref-counting (internal to the common clock
> framework) when clk_enable is called.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-pll.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index b46cca953f4f..65eeae0989d9 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -309,10 +309,12 @@ const struct clk_ops meson_clk_pll_ops = {
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
>  	.round_rate	= meson_clk_pll_round_rate,
>  	.set_rate	= meson_clk_pll_set_rate,
> +	.is_enabled	= meson_clk_pll_is_enabled,
>  	.enable		= meson_clk_pll_enable,
>  	.disable	= meson_clk_pll_disable
>  };
>  
>  const struct clk_ops meson_clk_pll_ro_ops = {
>  	.recalc_rate	= meson_clk_pll_recalc_rate,
> +	.is_enabled	= meson_clk_pll_is_enabled,
>  };

Looks good to me
Feel free to squash this with patch 3.

Jerome
