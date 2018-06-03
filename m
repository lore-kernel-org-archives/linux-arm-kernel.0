From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 09:52:13 -0300
Subject: [PATCH 3/4] clk: imx6sx: remove clks_init_on array
In-Reply-To: <1527994847-2363-3-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <1527994847-2363-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5A7-P265zhzwFBMv=HzaqJwPXx9fJ6Gom4kvS1X0uZoSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sx.c | 40 ++++++++++++++--------------------------
>  1 file changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
> index 10c771b..aed4391 100644
> --- a/drivers/clk/imx/clk-imx6sx.c
> +++ b/drivers/clk/imx/clk-imx6sx.c
> @@ -92,14 +92,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
>  static struct clk *clks[IMX6SX_CLK_CLK_END];
>  static struct clk_onecell_data clk_data;
>
> -static int const clks_init_on[] __initconst = {
> -       IMX6SX_CLK_AIPS_TZ1, IMX6SX_CLK_AIPS_TZ2, IMX6SX_CLK_AIPS_TZ3,
> -       IMX6SX_CLK_IPMUX1, IMX6SX_CLK_IPMUX2, IMX6SX_CLK_IPMUX3,
> -       IMX6SX_CLK_WAKEUP, IMX6SX_CLK_MMDC_P0_FAST, IMX6SX_CLK_MMDC_P0_IPG,
> -       IMX6SX_CLK_ROM, IMX6SX_CLK_ARM, IMX6SX_CLK_IPG, IMX6SX_CLK_OCRAM,
> -       IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_TZASC1,
> -};


MX6SX_CLK_ARM and IMX6SX_CLK_IPG did not have the CLK_IS_CRITICAL flag.

Is this on purpose?
