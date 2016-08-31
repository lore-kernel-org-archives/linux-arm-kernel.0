From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 31 Aug 2016 07:15:45 +0000
Subject: [Fwd: Re: [PATCH v2 1/6] clk: tegra: add TEGRA20_CLK_NOR to init
 table]
References: <1472569308.5703.22.camel@toradex.com>
Message-ID: <1472627744.31008.2.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-24 at 15:37 +0200, Mirza Krak wrote:
> 
> From: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add TEGRA20_CLK_NOR to init tabel and set default rate to 92 MHz
> which
> is max rate.

table

> 
> Signed-off-by: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.g
> mane.org>
> ---
> Changes in v2:
> - no changes
> 
> ?drivers/clk/tegra/clk-tegra20.c | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-
> tegra20.c
> index 837e5cb..13d3b5a 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -1047,6 +1047,7 @@ static struct tegra_clk_init_table init_table[]
> __initdata = {
> ?	{ TEGRA20_CLK_SDMMC3, TEGRA20_CLK_PLL_P, 48000000, 0 },
> ?	{ TEGRA20_CLK_SDMMC4, TEGRA20_CLK_PLL_P, 48000000, 0 },
> ?	{ TEGRA20_CLK_SPI, TEGRA20_CLK_PLL_P, 20000000, 0 },
> +	{ TEGRA20_CLK_NOR, TEGRA20_CLK_PLL_P, 92000000, 0 },

I'm just curious where that 92 MHz came from. According to the Tegra 2
Interface Design Guide up to 133 MHz should actually be possible.

> 
> ?	{ TEGRA20_CLK_SBC1, TEGRA20_CLK_PLL_P, 100000000, 0 },
> ?	{ TEGRA20_CLK_SBC2, TEGRA20_CLK_PLL_P, 100000000, 0 },
> ?	{ TEGRA20_CLK_SBC3, TEGRA20_CLK_PLL_P, 100000000, 0 },
> --
> 2.1.4
