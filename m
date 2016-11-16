From: oss@buserror.net (Scott Wood)
Date: Wed, 16 Nov 2016 00:54:22 -0600
Subject: [PATCH] clk: qoriq: added ls1012a clock configuration
In-Reply-To: <1479275900-42365-1-git-send-email-yuantian.tang@nxp.com>
References: <1479275900-42365-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <1479279262.21746.40.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-16 at 13:58 +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Added ls1012a clock configuation information.

Do we really need the same line in the changelog twice?

> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
> ?drivers/clk/clk-qoriq.c | 19 +++++++++++++++++++
> ?1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 1bece0f..563d874 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -202,6 +202,14 @@ static const struct clockgen_muxinfo ls1021a_cmux = {
> ?	}
> ?};
> ?
> +static const struct clockgen_muxinfo ls1012a_cmux = {
> +	{
> +		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
> +		{},
> +		[2] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
> +	}
> +};
> +

Based on the "ls1021a_cmux" in the context it looks like this patch is
intended to apply on top of?https://patchwork.kernel.org/patch/8923541/?but I
don't see any mention of that.

> ?static const struct clockgen_muxinfo t1040_cmux = {
> ?	{
> ?		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
> @@ -482,6 +490,16 @@ static const struct clockgen_chipinfo chipinfo[] = {
> ?		.pll_mask = 0x03,
> ?	},
> ?	{
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
> ?		.compat = "fsl,ls1043a-clockgen",
> ?		.init_periph = t2080_init_periph,
> ?		.cmux_groups = {
> @@ -1284,6 +1302,7 @@ CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-
> 2.0", clockgen_init);
> ?CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen",
> clockgen_init);
> ?CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen",
> clockgen_init);
> ?CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen",
> clockgen_init);
> +CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen",
> clockgen_init);

Please keep these lists of chips sorted (or as close as you can in the case of
the cmux structs which already have some sorting issues).

-Scott
