From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 Mar 2015 11:41:17 +0100
Subject: [PATCH] clk: don't use __initconst for non-const arrays
In-Reply-To: <1424253585-27011-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424253585-27011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150325104117.GD32677@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 10:59:45AM +0100, Uwe Kleine-K?nig wrote:
> The statement
> 
> 	static const char *name[];
> 
> defines a modifiable array of pointers to constant chars. That is
> 
> 	*name[0] = 'f';
> 
> is forbidden, but
> 
> 	name[0] = "f";
> 
> is not. So marking an array that is defined as above with __initconst is
> wrong. Either an additional const must be added such that the whole
> definition reads:
> 
> 	static const char *const name[] __initconst;
> 
> or where this is not possible __initdata must be used.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
gentle ping

Uwe

> ---
>  drivers/clk/hisilicon/clk-hi3620.c  | 70 ++++++++++++++++++-------------------
>  drivers/clk/hisilicon/clk-hix5hd2.c |  6 ++--
>  drivers/clk/mxs/clk-imx23.c         | 12 +++----
>  drivers/clk/mxs/clk-imx28.c         | 18 +++++-----
>  drivers/clk/pxa/clk-pxa.h           |  2 +-
>  drivers/clk/rockchip/clk-rk3188.c   |  2 +-
>  drivers/clk/rockchip/clk-rk3288.c   |  2 +-
>  drivers/clk/rockchip/clk.c          |  3 +-
>  drivers/clk/rockchip/clk.h          |  2 +-
>  drivers/clk/samsung/clk-s5pv210.c   | 56 ++++++++++++++---------------
>  drivers/clk/ti/composite.c          |  2 +-
>  drivers/clk/zynq/clkc.c             | 24 ++++++-------
>  12 files changed, 100 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
> index 007144f81f50..480c24e24f8e 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -38,44 +38,44 @@
>  #include "clk.h"
>  
>  /* clock parent list */
> -static const char *timer0_mux_p[] __initconst = { "osc32k", "timerclk01", };
> -static const char *timer1_mux_p[] __initconst = { "osc32k", "timerclk01", };
> -static const char *timer2_mux_p[] __initconst = { "osc32k", "timerclk23", };
> -static const char *timer3_mux_p[] __initconst = { "osc32k", "timerclk23", };
> -static const char *timer4_mux_p[] __initconst = { "osc32k", "timerclk45", };
> -static const char *timer5_mux_p[] __initconst = { "osc32k", "timerclk45", };
> -static const char *timer6_mux_p[] __initconst = { "osc32k", "timerclk67", };
> -static const char *timer7_mux_p[] __initconst = { "osc32k", "timerclk67", };
> -static const char *timer8_mux_p[] __initconst = { "osc32k", "timerclk89", };
> -static const char *timer9_mux_p[] __initconst = { "osc32k", "timerclk89", };
> -static const char *uart0_mux_p[] __initconst = { "osc26m", "pclk", };
> -static const char *uart1_mux_p[] __initconst = { "osc26m", "pclk", };
> -static const char *uart2_mux_p[] __initconst = { "osc26m", "pclk", };
> -static const char *uart3_mux_p[] __initconst = { "osc26m", "pclk", };
> -static const char *uart4_mux_p[] __initconst = { "osc26m", "pclk", };
> -static const char *spi0_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
> -static const char *spi1_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
> -static const char *spi2_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
> +static const char *timer0_mux_p[] __initdata = { "osc32k", "timerclk01", };
> +static const char *timer1_mux_p[] __initdata = { "osc32k", "timerclk01", };
> +static const char *timer2_mux_p[] __initdata = { "osc32k", "timerclk23", };
> +static const char *timer3_mux_p[] __initdata = { "osc32k", "timerclk23", };
> +static const char *timer4_mux_p[] __initdata = { "osc32k", "timerclk45", };
> +static const char *timer5_mux_p[] __initdata = { "osc32k", "timerclk45", };
> +static const char *timer6_mux_p[] __initdata = { "osc32k", "timerclk67", };
> +static const char *timer7_mux_p[] __initdata = { "osc32k", "timerclk67", };
> +static const char *timer8_mux_p[] __initdata = { "osc32k", "timerclk89", };
> +static const char *timer9_mux_p[] __initdata = { "osc32k", "timerclk89", };
> +static const char *uart0_mux_p[] __initdata = { "osc26m", "pclk", };
> +static const char *uart1_mux_p[] __initdata = { "osc26m", "pclk", };
> +static const char *uart2_mux_p[] __initdata = { "osc26m", "pclk", };
> +static const char *uart3_mux_p[] __initdata = { "osc26m", "pclk", };
> +static const char *uart4_mux_p[] __initdata = { "osc26m", "pclk", };
> +static const char *spi0_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
> +static const char *spi1_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
> +static const char *spi2_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
>  /* share axi parent */
> -static const char *saxi_mux_p[] __initconst = { "armpll3", "armpll2", };
> -static const char *pwm0_mux_p[] __initconst = { "osc32k", "osc26m", };
> -static const char *pwm1_mux_p[] __initconst = { "osc32k", "osc26m", };
> -static const char *sd_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *mmc1_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *mmc1_mux2_p[] __initconst = { "osc26m", "mmc1_div", };
> -static const char *g2d_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *venc_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *vdec_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *vpp_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *edc0_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *ldi0_mux_p[] __initconst = { "armpll2", "armpll4",
> +static const char *saxi_mux_p[] __initdata = { "armpll3", "armpll2", };
> +static const char *pwm0_mux_p[] __initdata = { "osc32k", "osc26m", };
> +static const char *pwm1_mux_p[] __initdata = { "osc32k", "osc26m", };
> +static const char *sd_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *mmc1_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *mmc1_mux2_p[] __initdata = { "osc26m", "mmc1_div", };
> +static const char *g2d_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *venc_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *vdec_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *vpp_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *edc0_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *ldi0_mux_p[] __initdata = { "armpll2", "armpll4",
>  					     "armpll3", "armpll5", };
> -static const char *edc1_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *ldi1_mux_p[] __initconst = { "armpll2", "armpll4",
> +static const char *edc1_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *ldi1_mux_p[] __initdata = { "armpll2", "armpll4",
>  					     "armpll3", "armpll5", };
> -static const char *rclk_hsic_p[] __initconst = { "armpll3", "armpll2", };
> -static const char *mmc2_mux_p[] __initconst = { "armpll2", "armpll3", };
> -static const char *mmc3_mux_p[] __initconst = { "armpll2", "armpll3", };
> +static const char *rclk_hsic_p[] __initdata = { "armpll3", "armpll2", };
> +static const char *mmc2_mux_p[] __initdata = { "armpll2", "armpll3", };
> +static const char *mmc3_mux_p[] __initdata = { "armpll2", "armpll3", };
>  
>  
>  /* fixed rate clocks */
> diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
> index 3f369c60fe56..f1d239435826 100644
> --- a/drivers/clk/hisilicon/clk-hix5hd2.c
> +++ b/drivers/clk/hisilicon/clk-hix5hd2.c
> @@ -46,15 +46,15 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
>  	{ HIX5HD2_FIXED_83M, "83m", NULL, CLK_IS_ROOT, 83333333, },
>  };
>  
> -static const char *sfc_mux_p[] __initconst = {
> +static const char *sfc_mux_p[] __initdata = {
>  		"24m", "150m", "200m", "100m", "75m", };
>  static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
>  
> -static const char *sdio_mux_p[] __initconst = {
> +static const char *sdio_mux_p[] __initdata = {
>  		"75m", "100m", "50m", "15m", };
>  static u32 sdio_mux_table[] = {0, 1, 2, 3};
>  
> -static const char *fephy_mux_p[] __initconst = { "25m", "125m"};
> +static const char *fephy_mux_p[] __initdata = { "25m", "125m"};
>  static u32 fephy_mux_table[] = {0, 1};
>  
>  
> diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
> index 9fc9359f5133..22d136aa699f 100644
> --- a/drivers/clk/mxs/clk-imx23.c
> +++ b/drivers/clk/mxs/clk-imx23.c
> @@ -77,12 +77,12 @@ static void __init clk_misc_init(void)
>  	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
>  }
>  
> -static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
> -static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
> -static const char *sel_pix[]  __initconst = { "ref_pix", "ref_xtal", };
> -static const char *sel_io[]   __initconst = { "ref_io", "ref_xtal", };
> -static const char *cpu_sels[] __initconst = { "cpu_pll", "cpu_xtal", };
> -static const char *emi_sels[] __initconst = { "emi_pll", "emi_xtal", };
> +static const char *sel_pll[]  __initdata = { "pll", "ref_xtal", };
> +static const char *sel_cpu[]  __initdata = { "ref_cpu", "ref_xtal", };
> +static const char *sel_pix[]  __initdata = { "ref_pix", "ref_xtal", };
> +static const char *sel_io[]   __initdata = { "ref_io", "ref_xtal", };
> +static const char *cpu_sels[] __initdata = { "cpu_pll", "cpu_xtal", };
> +static const char *emi_sels[] __initdata = { "emi_pll", "emi_xtal", };
>  
>  enum imx23_clk {
>  	ref_xtal, pll, ref_cpu, ref_emi, ref_pix, ref_io, saif_sel,
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index a6c35010e4e5..b1be3746ce95 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -125,15 +125,15 @@ static void __init clk_misc_init(void)
>  	writel_relaxed(val, FRAC0);
>  }
>  
> -static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
> -static const char *sel_io0[]  __initconst = { "ref_io0", "ref_xtal", };
> -static const char *sel_io1[]  __initconst = { "ref_io1", "ref_xtal", };
> -static const char *sel_pix[]  __initconst = { "ref_pix", "ref_xtal", };
> -static const char *sel_gpmi[] __initconst = { "ref_gpmi", "ref_xtal", };
> -static const char *sel_pll0[] __initconst = { "pll0", "ref_xtal", };
> -static const char *cpu_sels[] __initconst = { "cpu_pll", "cpu_xtal", };
> -static const char *emi_sels[] __initconst = { "emi_pll", "emi_xtal", };
> -static const char *ptp_sels[] __initconst = { "ref_xtal", "pll0", };
> +static const char *sel_cpu[]  __initdata = { "ref_cpu", "ref_xtal", };
> +static const char *sel_io0[]  __initdata = { "ref_io0", "ref_xtal", };
> +static const char *sel_io1[]  __initdata = { "ref_io1", "ref_xtal", };
> +static const char *sel_pix[]  __initdata = { "ref_pix", "ref_xtal", };
> +static const char *sel_gpmi[] __initdata = { "ref_gpmi", "ref_xtal", };
> +static const char *sel_pll0[] __initdata = { "pll0", "ref_xtal", };
> +static const char *cpu_sels[] __initdata = { "cpu_pll", "cpu_xtal", };
> +static const char *emi_sels[] __initdata = { "emi_pll", "emi_xtal", };
> +static const char *ptp_sels[] __initdata = { "ref_xtal", "pll0", };
>  
>  enum imx28_clk {
>  	ref_xtal, pll0, pll1, pll2, ref_cpu, ref_emi, ref_io0, ref_io1,
> diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
> index 323965430111..b04c5b9c0ea8 100644
> --- a/drivers/clk/pxa/clk-pxa.h
> +++ b/drivers/clk/pxa/clk-pxa.h
> @@ -14,7 +14,7 @@
>  #define _CLK_PXA_
>  
>  #define PARENTS(name) \
> -	static const char *name ## _parents[] __initconst
> +	static const char *name ## _parents[] __initdata
>  #define MUX_RO_RATE_RO_OPS(name, clk_name)			\
>  	static struct clk_hw name ## _mux_hw;			\
>  	static struct clk_hw name ## _rate_hw;			\
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
> index 7eb684c50d42..556ce041d371 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -704,7 +704,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
>  	GATE(ACLK_GPS, "aclk_gps", "aclk_peri", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
>  };
>  
> -static const char *rk3188_critical_clocks[] __initconst = {
> +static const char *const rk3188_critical_clocks[] __initconst = {
>  	"aclk_cpu",
>  	"aclk_peri",
>  	"hclk_peri",
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 11194b8329fe..434b42ccd7e7 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -771,7 +771,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>  	GATE(0, "pclk_isp_in", "ext_isp", 0, RK3288_CLKGATE_CON(16), 3, GFLAGS),
>  };
>  
> -static const char *rk3288_critical_clocks[] __initconst = {
> +static const char *const rk3288_critical_clocks[] __initconst = {
>  	"aclk_cpu",
>  	"aclk_peri",
>  	"hclk_peri",
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 20e05bbb3a67..edb5d489ae61 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -317,7 +317,8 @@ void __init rockchip_clk_register_armclk(unsigned int lookup_id,
>  	rockchip_clk_add_lookup(clk, lookup_id);
>  }
>  
> -void __init rockchip_clk_protect_critical(const char *clocks[], int nclocks)
> +void __init rockchip_clk_protect_critical(const char *const clocks[],
> +					  int nclocks)
>  {
>  	int i;
>  
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 58d2e3bdf22f..e42fe095a9c0 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -182,7 +182,7 @@ struct clk *rockchip_clk_register_mmc(const char *name,
>  				const char **parent_names, u8 num_parents,
>  				void __iomem *reg, int shift);
>  
> -#define PNAME(x) static const char *x[] __initconst
> +#define PNAME(x) static const char *x[] __initdata
>  
>  enum rockchip_clk_branch_type {
>  	branch_composite,
> diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
> index d270a2084644..e668e479a697 100644
> --- a/drivers/clk/samsung/clk-s5pv210.c
> +++ b/drivers/clk/samsung/clk-s5pv210.c
> @@ -169,44 +169,44 @@ static inline void s5pv210_clk_sleep_init(void) { }
>  #endif
>  
>  /* Mux parent lists. */
> -static const char *fin_pll_p[] __initconst = {
> +static const char *fin_pll_p[] __initdata = {
>  	"xxti",
>  	"xusbxti"
>  };
>  
> -static const char *mout_apll_p[] __initconst = {
> +static const char *mout_apll_p[] __initdata = {
>  	"fin_pll",
>  	"fout_apll"
>  };
>  
> -static const char *mout_mpll_p[] __initconst = {
> +static const char *mout_mpll_p[] __initdata = {
>  	"fin_pll",
>  	"fout_mpll"
>  };
>  
> -static const char *mout_epll_p[] __initconst = {
> +static const char *mout_epll_p[] __initdata = {
>  	"fin_pll",
>  	"fout_epll"
>  };
>  
> -static const char *mout_vpllsrc_p[] __initconst = {
> +static const char *mout_vpllsrc_p[] __initdata = {
>  	"fin_pll",
>  	"sclk_hdmi27m"
>  };
>  
> -static const char *mout_vpll_p[] __initconst = {
> +static const char *mout_vpll_p[] __initdata = {
>  	"mout_vpllsrc",
>  	"fout_vpll"
>  };
>  
> -static const char *mout_group1_p[] __initconst = {
> +static const char *mout_group1_p[] __initdata = {
>  	"dout_a2m",
>  	"mout_mpll",
>  	"mout_epll",
>  	"mout_vpll"
>  };
>  
> -static const char *mout_group2_p[] __initconst = {
> +static const char *mout_group2_p[] __initdata = {
>  	"xxti",
>  	"xusbxti",
>  	"sclk_hdmi27m",
> @@ -218,7 +218,7 @@ static const char *mout_group2_p[] __initconst = {
>  	"mout_vpll",
>  };
>  
> -static const char *mout_audio0_p[] __initconst = {
> +static const char *mout_audio0_p[] __initdata = {
>  	"xxti",
>  	"pcmcdclk0",
>  	"sclk_hdmi27m",
> @@ -230,7 +230,7 @@ static const char *mout_audio0_p[] __initconst = {
>  	"mout_vpll",
>  };
>  
> -static const char *mout_audio1_p[] __initconst = {
> +static const char *mout_audio1_p[] __initdata = {
>  	"i2scdclk1",
>  	"pcmcdclk1",
>  	"sclk_hdmi27m",
> @@ -242,7 +242,7 @@ static const char *mout_audio1_p[] __initconst = {
>  	"mout_vpll",
>  };
>  
> -static const char *mout_audio2_p[] __initconst = {
> +static const char *mout_audio2_p[] __initdata = {
>  	"i2scdclk2",
>  	"pcmcdclk2",
>  	"sclk_hdmi27m",
> @@ -254,63 +254,63 @@ static const char *mout_audio2_p[] __initconst = {
>  	"mout_vpll",
>  };
>  
> -static const char *mout_spdif_p[] __initconst = {
> +static const char *mout_spdif_p[] __initdata = {
>  	"dout_audio0",
>  	"dout_audio1",
>  	"dout_audio3",
>  };
>  
> -static const char *mout_group3_p[] __initconst = {
> +static const char *mout_group3_p[] __initdata = {
>  	"mout_apll",
>  	"mout_mpll"
>  };
>  
> -static const char *mout_group4_p[] __initconst = {
> +static const char *mout_group4_p[] __initdata = {
>  	"mout_mpll",
>  	"dout_a2m"
>  };
>  
> -static const char *mout_flash_p[] __initconst = {
> +static const char *mout_flash_p[] __initdata = {
>  	"dout_hclkd",
>  	"dout_hclkp"
>  };
>  
> -static const char *mout_dac_p[] __initconst = {
> +static const char *mout_dac_p[] __initdata = {
>  	"mout_vpll",
>  	"sclk_hdmiphy"
>  };
>  
> -static const char *mout_hdmi_p[] __initconst = {
> +static const char *mout_hdmi_p[] __initdata = {
>  	"sclk_hdmiphy",
>  	"dout_tblk"
>  };
>  
> -static const char *mout_mixer_p[] __initconst = {
> +static const char *mout_mixer_p[] __initdata = {
>  	"mout_dac",
>  	"mout_hdmi"
>  };
>  
> -static const char *mout_vpll_6442_p[] __initconst = {
> +static const char *mout_vpll_6442_p[] __initdata = {
>  	"fin_pll",
>  	"fout_vpll"
>  };
>  
> -static const char *mout_mixer_6442_p[] __initconst = {
> +static const char *mout_mixer_6442_p[] __initdata = {
>  	"mout_vpll",
>  	"dout_mixer"
>  };
>  
> -static const char *mout_d0sync_6442_p[] __initconst = {
> +static const char *mout_d0sync_6442_p[] __initdata = {
>  	"mout_dsys",
>  	"div_apll"
>  };
>  
> -static const char *mout_d1sync_6442_p[] __initconst = {
> +static const char *mout_d1sync_6442_p[] __initdata = {
>  	"mout_psys",
>  	"div_apll"
>  };
>  
> -static const char *mout_group2_6442_p[] __initconst = {
> +static const char *mout_group2_6442_p[] __initdata = {
>  	"fin_pll",
>  	"none",
>  	"none",
> @@ -322,7 +322,7 @@ static const char *mout_group2_6442_p[] __initconst = {
>  	"mout_vpll",
>  };
>  
> -static const char *mout_audio0_6442_p[] __initconst = {
> +static const char *mout_audio0_6442_p[] __initdata = {
>  	"fin_pll",
>  	"pcmcdclk0",
>  	"none",
> @@ -334,7 +334,7 @@ static const char *mout_audio0_6442_p[] __initconst = {
>  	"mout_vpll",
>  };
>  
> -static const char *mout_audio1_6442_p[] __initconst = {
> +static const char *mout_audio1_6442_p[] __initdata = {
>  	"i2scdclk1",
>  	"pcmcdclk1",
>  	"none",
> @@ -347,7 +347,7 @@ static const char *mout_audio1_6442_p[] __initconst = {
>  	"fin_pll",
>  };
>  
> -static const char *mout_clksel_p[] __initconst = {
> +static const char *mout_clksel_p[] __initdata = {
>  	"fout_apll_clkout",
>  	"fout_mpll_clkout",
>  	"fout_epll",
> @@ -370,7 +370,7 @@ static const char *mout_clksel_p[] __initconst = {
>  	"div_dclk"
>  };
>  
> -static const char *mout_clksel_6442_p[] __initconst = {
> +static const char *mout_clksel_6442_p[] __initdata = {
>  	"fout_apll_clkout",
>  	"fout_mpll_clkout",
>  	"fout_epll",
> @@ -393,7 +393,7 @@ static const char *mout_clksel_6442_p[] __initconst = {
>  	"div_dclk"
>  };
>  
> -static const char *mout_clkout_p[] __initconst = {
> +static const char *mout_clkout_p[] __initdata = {
>  	"dout_clkout",
>  	"none",
>  	"xxti",
> diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
> index 19d8980ba458..c429c65b5b21 100644
> --- a/drivers/clk/ti/composite.c
> +++ b/drivers/clk/ti/composite.c
> @@ -67,7 +67,7 @@ struct component_clk {
>  	struct list_head link;
>  };
>  
> -static const char * __initconst component_clk_types[] = {
> +static const char * const component_clk_types[] __initconst = {
>  	"gate", "divider", "mux"
>  };
>  
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 9037bebd69f7..5ac254f7e3b8 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -85,22 +85,22 @@ static DEFINE_SPINLOCK(canmioclk_lock);
>  static DEFINE_SPINLOCK(dbgclk_lock);
>  static DEFINE_SPINLOCK(aperclk_lock);
>  
> -static const char *armpll_parents[] __initconst = {"armpll_int", "ps_clk"};
> -static const char *ddrpll_parents[] __initconst = {"ddrpll_int", "ps_clk"};
> -static const char *iopll_parents[] __initconst = {"iopll_int", "ps_clk"};
> -static const char *gem0_mux_parents[] __initconst = {"gem0_div1", "dummy_name"};
> -static const char *gem1_mux_parents[] __initconst = {"gem1_div1", "dummy_name"};
> -static const char *can0_mio_mux2_parents[] __initconst = {"can0_gate",
> +static const char *armpll_parents[] __initdata = {"armpll_int", "ps_clk"};
> +static const char *ddrpll_parents[] __initdata = {"ddrpll_int", "ps_clk"};
> +static const char *iopll_parents[] __initdata = {"iopll_int", "ps_clk"};
> +static const char *gem0_mux_parents[] __initdata = {"gem0_div1", "dummy_name"};
> +static const char *gem1_mux_parents[] __initdata = {"gem1_div1", "dummy_name"};
> +static const char *can0_mio_mux2_parents[] __initdata = {"can0_gate",
>  	"can0_mio_mux"};
> -static const char *can1_mio_mux2_parents[] __initconst = {"can1_gate",
> +static const char *can1_mio_mux2_parents[] __initdata = {"can1_gate",
>  	"can1_mio_mux"};
> -static const char *dbg_emio_mux_parents[] __initconst = {"dbg_div",
> +static const char *dbg_emio_mux_parents[] __initdata = {"dbg_div",
>  	"dummy_name"};
>  
> -static const char *dbgtrc_emio_input_names[] __initconst = {"trace_emio_clk"};
> -static const char *gem0_emio_input_names[] __initconst = {"gem0_emio_clk"};
> -static const char *gem1_emio_input_names[] __initconst = {"gem1_emio_clk"};
> -static const char *swdt_ext_clk_input_names[] __initconst = {"swdt_ext_clk"};
> +static const char *dbgtrc_emio_input_names[] __initdata = {"trace_emio_clk"};
> +static const char *gem0_emio_input_names[] __initdata = {"gem0_emio_clk"};
> +static const char *gem1_emio_input_names[] __initdata = {"gem1_emio_clk"};
> +static const char *swdt_ext_clk_input_names[] __initdata = {"swdt_ext_clk"};
>  
>  static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
>  		const char *clk_name, void __iomem *fclk_ctrl_reg,
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
