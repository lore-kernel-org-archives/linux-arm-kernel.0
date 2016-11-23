From: scott.wood@nxp.com (Scott Wood)
Date: Wed, 23 Nov 2016 07:27:07 +0000
Subject: [PATCH v2] clk: qoriq: added ls1012a clock configuration
References: <1479802499-9083-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <DB5PR0401MB1928B72A81C6867EB699AB0C91B70@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2016 02:28 AM, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
> v2:
>   - remove commit message as it is duplicated to title
> 
>  drivers/clk/clk-qoriq.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 1bece0f..65c21d7 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -202,6 +202,14 @@ static const struct clockgen_muxinfo ls1021a_cmux = {
>  	}
>  };
>  
> +static const struct clockgen_muxinfo ls1012a_cmux = {
> +	{
> +		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
> +		{},
> +		[2] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
> +	}
> +};
> +
>  static const struct clockgen_muxinfo t1040_cmux = {
>  	{
>  		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
> @@ -482,6 +490,16 @@ static const struct clockgen_chipinfo chipinfo[] = {
>  		.pll_mask = 0x03,
>  	},
>  	{
> +		.compat = "fsl,ls1012a-clockgen",
> +		.cmux_groups = {
> +			&ls1012a_cmux
> +		},
> +		.cmux_to_group = {
> +			0, -1
> +		},
> +		.pll_mask = 0x03,
> +	},
> +	{
>  		.compat = "fsl,ls1043a-clockgen",
>  		.init_periph = t2080_init_periph,
>  		.cmux_groups = {
> @@ -1282,6 +1300,7 @@ static void __init clockgen_init(struct device_node *np)
>  CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
> +CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);

Again, can you please keep the chip lists sorted?  ls1012a doesn't go
after ls1021a.

-Scott
