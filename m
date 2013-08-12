From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Aug 2013 13:53:58 +0100
Subject: [PATCH 3/4] clk: sunxi: Add A31 clocks support
In-Reply-To: <1375195462-19566-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130812125357.GD6616@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 03:44:21PM +0100, Maxime Ripard wrote:
> The A31 has a mostly different clock set compared to the other older
> SoCs currently supported in the Allwinner clock driver.
> 
> Add support for the basic useful clocks. The other ones will come in
> eventually.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 120 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 

[...]

> @@ -420,6 +516,10 @@ static const __initconst struct of_device_id clk_factors_match[] = {
>  		.data = &sun4i_pll1_data,
>  	},
>  	{
> +		.compatible = "allwinner,sun6i-pll1-clk",
> +		.data = &sun6i_pll1_data,
> +	},
> +	{
>  		.compatible = "allwinner,sun4i-apb1-clk",
>  		.data = &sun4i_apb1_data,
>  	},
> @@ -440,6 +540,10 @@ static const __initconst struct of_device_id clk_div_match[] = {
>  		.compatible = "allwinner,sun4i-apb0-clk",
>  		.data = &sun4i_apb0_data,
>  	},
> +	{
> +		.compatible = "allwinner,sun6i-apb2-div-clk",
> +		.data = &sun6i_apb2_div_data,
> +	},
>  	{}
>  };
>  
> @@ -453,6 +557,10 @@ static const __initconst struct of_device_id clk_mux_match[] = {
>  		.compatible = "allwinner,sun4i-apb1-mux-clk",
>  		.data = &sun4i_apb1_mux_data,
>  	},
> +	{
> +		.compatible = "allwinner,sun6i-ahb1-mux-clk",
> +		.data = &sun6i_ahb1_mux_data,
> +	},
>  	{}
>  };
>  
> @@ -471,6 +579,10 @@ static const __initconst struct of_device_id clk_gates_match[] = {
>  		.data = &sun5i_a13_ahb_gates_data,
>  	},
>  	{
> +		.compatible = "allwinner,sun6i-a31-ahb1-gates-clk",
> +		.data = &sun6i_a31_ahb1_gates_data,
> +	},
> +	{
>  		.compatible = "allwinner,sun4i-apb0-gates-clk",
>  		.data = &sun4i_apb0_gates_data,
>  	},
> @@ -486,6 +598,14 @@ static const __initconst struct of_device_id clk_gates_match[] = {
>  		.compatible = "allwinner,sun5i-a13-apb1-gates-clk",
>  		.data = &sun5i_a13_apb1_gates_data,
>  	},
> +	{
> +		.compatible = "allwinner,sun6i-a31-apb1-gates-clk",
> +		.data = &sun6i_a31_apb1_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun6i-a31-apb2-gates-clk",
> +		.data = &sun6i_a31_apb2_gates_data,
> +	},
>  	{}
>  };

Could you please document these new strings? I assume they follow the
general conventions of sunxi clocks thus far and the strings can just be
appended to the lists in the existing binding document.

Thanks,
Mark.
