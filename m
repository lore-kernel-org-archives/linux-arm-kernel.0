From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jul 2016 13:17:35 +0200
Subject: [RFC 1/6] clk: tegra: add TEGRA20_CLK_NOR to init table
In-Reply-To: <1468935397-11926-2-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-2-git-send-email-mirza.krak@gmail.com>
Message-ID: <20160725111735.GC21170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 03:36:32PM +0200, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add TEGRA20_CLK_NOR to init tabel and set a "sane" default rate.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index 837e5cb..aefc044 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -1047,6 +1047,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>  	{ TEGRA20_CLK_SDMMC3, TEGRA20_CLK_PLL_P, 48000000, 0 },
>  	{ TEGRA20_CLK_SDMMC4, TEGRA20_CLK_PLL_P, 48000000, 0 },
>  	{ TEGRA20_CLK_SPI, TEGRA20_CLK_PLL_P, 20000000, 0 },
> +	{ TEGRA20_CLK_NOR, TEGRA20_CLK_PLL_P, 86500000, 0 },

Yay for inconsistent naming in the hardware. It would've been nice if
this clock was called GMI. Oh well...

Could you perhaps explain in the commit message why 86.5 MHz is a sane
default? I'm totally unfamiliar with this controller, so maybe it's
self-explanatory, but it seems a rather odd value for a clock frequency.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/8f6048d2/attachment.sig>
