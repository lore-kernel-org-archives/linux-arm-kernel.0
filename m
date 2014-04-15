From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 19:56:39 +0200
Subject: [PATCH v2 5/7] clk: exynos5420: Add missing clocks
In-Reply-To: <1395918470-16374-6-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
 <1395918470-16374-6-git-send-email-shaik.ameer@samsung.com>
Message-ID: <534D72D7.4000902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 27.03.2014 12:07, Shaik Ameer Basha wrote:
> From: Rahul Sharma <rahul.sharma@samsung.com>
>
> This patch adds the missing clocks related to the modules
> like FIMD, DP, GSCL, MSCL, ISP, MFC etc.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5420.c |  221 +++++++++++++++++++++++++++++++++-
>   1 file changed, 219 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 793fb3d..26ddf33 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -269,15 +269,36 @@ PNAME(mout_group3_p) = {"mout_sclk_rpll", "mout_sclk_spll"};
>   PNAME(mout_group4_p) = {"mout_sclk_ipll", "mout_sclk_dpll", "mout_sclk_mpll"};
>   PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
>
> +PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
>   PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
>   PNAME(mout_user_aclk66_peric_p) = {"fin_pll", "mout_sw_aclk66"};
> +PNAME(mout_user_aclk66_gpio_p) = {"mout_sw_aclk66", "ffactor_sw_aclk66"};
>
>   PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
> +PNAME(mout_sw_pclk200_fsys_p) = {"dout_pclk200_fsys", "mout_sclk_spll"};
> +PNAME(mout_user_pclk200_fsys_p)	= {"fin_pll", "mout_sw_pclk200_fsys"};
>   PNAME(mout_user_aclk200_fsys_p)	= {"fin_pll", "mout_sw_aclk200_fsys"};
>
>   PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2", "mout_sclk_spll"};
>   PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
>
> +PNAME(mout_sw_aclk100_noc_p) = {"dout_aclk100_noc", "mout_sclk_spll"};
> +PNAME(mout_user_aclk100_noc_p) = {"fin_pll", "mout_sw_aclk100_noc"};
> +
> +PNAME(mout_sw_aclk400_wcore_p) = {"dout_aclk400_wcore", "mout_sclk_spll"};
> +PNAME(mout_aclk400_wcore_bpll_p) = {"mout_aclk400_wcore", "sclk_bpll"};
> +PNAME(mout_user_aclk400_wcore_p) = {"fin_pll", "mout_sw_aclk400_wcore"};
> +
> +PNAME(mout_sw_aclk400_isp_p) = {"dout_aclk400_isp", "mout_sclk_spll"};
> +PNAME(mout_user_aclk400_isp_p) = {"fin_pll", "mout_sw_aclk400_isp"};
> +
> +PNAME(mout_sw_aclk333_432_isp0_p) = {"dout_aclk333_432_isp0",
> +					"mout_sclk_spll"};
> +PNAME(mout_user_aclk333_432_isp0_p) = {"fin_pll", "mout_sw_aclk333_432_isp0"};
> +
> +PNAME(mout_sw_aclk333_432_isp_p) = {"dout_aclk333_432_isp", "mout_sclk_spll"};
> +PNAME(mout_user_aclk333_432_isp_p) = {"fin_pll", "mout_sw_aclk333_432_isp"};
> +
>   PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
>   PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
>
> @@ -292,6 +313,7 @@ PNAME(mout_user_aclk166_p) = {"fin_pll", "mout_sw_aclk166"};
>
>   PNAME(mout_sw_aclk266_p) = {"dout_aclk266", "mout_sclk_spll"};
>   PNAME(mout_user_aclk266_p) = {"fin_pll", "mout_sw_aclk266"};
> +PNAME(mout_user_aclk266_isp_p) = {"fin_pll", "mout_sw_aclk266"};
>
>   PNAME(mout_sw_aclk333_432_gscl_p) = {"dout_aclk333_432_gscl", "mout_sclk_spll"};
>   PNAME(mout_user_aclk333_432_gscl_p) = {"fin_pll", "mout_sw_aclk333_432_gscl"};
> @@ -300,7 +322,9 @@ PNAME(mout_sw_aclk300_gscl_p) = {"dout_aclk300_gscl", "mout_sclk_spll"};
>   PNAME(mout_user_aclk300_gscl_p)	= {"fin_pll", "mout_sw_aclk300_gscl"};
>
>   PNAME(mout_sw_aclk300_disp1_p) = {"dout_aclk300_disp1", "mout_sclk_spll"};
> +PNAME(mout_sw_aclk400_disp1_p) = {"dout_aclk400_disp1", "mout_sclk_spll"};
>   PNAME(mout_user_aclk300_disp1_p) = {"fin_pll", "mout_sw_aclk300_disp1"};
> +PNAME(mout_user_aclk400_disp1_p) = {"fin_pll", "mout_sw_aclk400_disp1"};
>
>   PNAME(mout_sw_aclk300_jpeg_p) = {"dout_aclk300_jpeg", "mout_sclk_spll"};
>   PNAME(mout_user_aclk300_jpeg_p) = {"fin_pll", "mout_sw_aclk300_jpeg"};
> @@ -330,6 +354,8 @@ PNAME(mout_hdmi_p) = {"dout_hdmi_pixel", "sclk_hdmiphy"};
>   PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
>   			 "mout_sclk_mpll", "mout_sclk_spll", "mout_sclk_ipll",
>   			 "mout_sclk_epll", "mout_sclk_rpll"};
> +PNAME(mout_mau_epll_clk_p) = {"mout_sclk_epll", "mout_sclk_dpll",
> +				"mout_sclk_mpll", "mout_sclk_spll"};
>
>   /* fixed rate clocks generated outside the soc */
>   static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
> @@ -347,6 +373,7 @@ static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata =
>
>   static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
>   	FFACTOR(0, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
> +	FFACTOR(0, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
>   };
>
>   static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
> @@ -452,6 +479,10 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(0, "mout_dp1", mout_group2_p, SRC_DISP10, 20, 3),
>   	MUX(0, "mout_pixel", mout_group2_p, SRC_DISP10, 24, 3),
>   	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP10, 28, 1),
> +	MUX_F(0, "mout_fimd1_opt", mout_group2_p, SRC_DISP10, 8, 3,
> +						CLK_SET_RATE_PARENT, 0),
> +	MUX_F(0, "mout_fimd1_final", mout_fimd1_final_p, TOP_SPARE2, 8, 1,
> +						CLK_SET_RATE_PARENT, 0),
>
>   	/* MAU Block */
>   	MUX_F(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3,
> @@ -464,6 +495,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(0, "mout_mmc2", mout_group2_p, SRC_FSYS, 16, 3),
>   	MUX(0, "mout_usbd300", mout_group2_p, SRC_FSYS, 20, 3),
>   	MUX(0, "mout_unipro", mout_group2_p, SRC_FSYS, 24, 3),
> +	MUX(0, "mout_mphy_refclk", mout_group2_p, SRC_FSYS, 28, 3),
>
>   	/* PERIC Block */
>   	MUX(0, "mout_uart0", mout_group2_p, SRC_PERIC0, 4, 3),
> @@ -478,6 +510,58 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>   	MUX(CLK_MOUT_SPI0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
>   	MUX(CLK_MOUT_SPI1, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
>   	MUX(CLK_MOUT_SPI2, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
> +
> +	MUX(0, "mout_user_aclk66_gpio", mout_user_aclk66_gpio_p,
> +		SRC_TOP7, 4, 1),
> +	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
> +		CLK_SET_RATE_PARENT, 0),
> +	MUX(0, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
> +	MUX(0, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
> +		SRC_TOP10, 24, 1),
> +	MUX(0, "mout_user_pclk200_fsys", mout_user_pclk200_fsys_p,
> +		SRC_TOP3, 24, 1),
> +	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
> +	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
> +		SRC_TOP10, 20, 1),
> +	MUX(0, "mout_user_aclk100_noc", mout_user_aclk100_noc_p,
> +		SRC_TOP3, 20, 1),
> +	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
> +	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
> +		TOP_SPARE2, 4, 1),
> +	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
> +		SRC_TOP10, 16, 1),
> +	MUX(0, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
> +		SRC_TOP3, 16, 1),
> +	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
> +	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
> +		SRC_TOP10, 0, 1),
> +	MUX(0, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
> +		SRC_TOP3, 0, 1),
> +	MUX(0, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
> +	MUX(0, "mout_sw_aclk333_432_isp0", mout_sw_aclk333_432_isp0_p,
> +		SRC_TOP11, 12, 1),
> +	MUX(0, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
> +		SRC_TOP4, 12, 1),
> +	MUX(0, "mout_aclk333_432_isp", mout_group4_p,
> +		SRC_TOP1, 4, 2),
> +	MUX(0, "mout_sw_aclk333_432_isp", mout_sw_aclk333_432_isp_p,
> +		SRC_TOP11, 4, 1),
> +	MUX(0, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
> +		SRC_TOP4, 4, 1),
> +	MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
> +		SRC_TOP4, 16, 1),
> +	MUX(0, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
> +	MUX(0, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
> +		SRC_TOP12, 4, 1),
> +	MUX(0, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
> +		SRC_TOP5, 0, 1),
> +
> +	/* ISP Block*/
> +	MUX(0, "mout_pwm_isp", mout_group2_p, SRC_ISP, 24, 3),
> +	MUX(0, "mout_uart_isp", mout_group2_p, SRC_ISP, 20, 3),
> +	MUX(0, "mout_spi0_isp", mout_group2_p, SRC_ISP, 12, 3),
> +	MUX(0, "mout_spi1_isp", mout_group2_p, SRC_ISP, 16, 3),
> +	MUX(0, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
>   };
>
>   static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
> @@ -512,6 +596,7 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>   	DIV(0, "dout_mipi1", "mout_mipi1", DIV_DISP10, 16, 8),
>   	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
>   	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
> +	DIV(0, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
>
>   	/* Audio Block */
>   	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
> @@ -529,6 +614,7 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>   	DIV(0, "dout_mmc2", "mout_mmc2", DIV_FSYS1, 20, 10),
>
>   	DIV(0, "dout_unipro", "mout_unipro", DIV_FSYS2, 24, 8),
> +	DIV(0, "dout_mphy_refclk", "mout_mphy_refclk", DIV_FSYS2, 16, 8),
>
>   	/* UART and PWM */
>   	DIV(0, "dout_uart0", "mout_uart0", DIV_PERIC0, 8, 4),
> @@ -557,6 +643,39 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>   	DIV(0, "dout_spi0_pre", "dout_spi0", DIV_PERIC4, 8, 8),
>   	DIV(0, "dout_spi1_pre", "dout_spi1", DIV_PERIC4, 16, 8),
>   	DIV(0, "dout_spi2_pre", "dout_spi2", DIV_PERIC4, 24, 8),
> +
> +	DIV(0, "dout_aclk400_disp1", "mout_aclk400_disp1",
> +		DIV_TOP2, 4, 3),
> +	DIV(0, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
> +	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
> +		DIV_TOP0, 16, 3),
> +	DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
> +	DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
> +		DIV_TOP1, 16, 3),
> +	DIV(0, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
> +		DIV_TOP1, 4, 3),
> +	/* Mfc Blk */
> +	DIV(0, "dout_mfc_blk", "mout_user_aclk333", DIV4_RATIO, 0, 2),
> +	/* Gscl Blk */
> +	DIV(0, "dout_gscl_blk_300", "mout_user_aclk300_gscl",
> +						DIV2_RATIO0, 4, 2),
> +	DIV(0, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
> +	/* Mscl Blk */
> +	DIV(0, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
> +	/* Psgen */
> +	DIV(0, "dout_gen_blk", "mout_user_aclk266", DIV2_RATIO0, 8, 1),
> +	/* Jpeg */
> +	DIV(0, "dout_jpg_blk", "aclk166", DIV2_RATIO0, 20, 1),
> +	/* isp */
> +	DIV(0, "dout_pwm_isp", "mout_pwm_isp", SCLK_DIV_ISP1, 28, 4),
> +	DIV(0, "dout_uart_isp", "mout_uart_isp", SCLK_DIV_ISP1, 24, 4),
> +	DIV(0, "dout_spi0_isp", "mout_spi0_isp", SCLK_DIV_ISP1, 16, 4),
> +	DIV(0, "dout_spi1_isp", "mout_spi1_isp", SCLK_DIV_ISP1, 20, 4),
> +	DIV(0, "dout_spi0_isp_pre", "dout_spi0_isp", SCLK_DIV_ISP1, 0, 8),
> +	DIV(0, "dout_spi1_isp_pre", "dout_spi1_isp", SCLK_DIV_ISP1, 8, 8),
> +	DIV(0, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
> +	DIV(0, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
> +	DIV(0, "dout_isp_sensor2", "mout_isp_sensor", SCLK_DIV_ISP0, 24, 8),
>   };
>
>   static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
> @@ -781,12 +900,18 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   	GATE(CLK_PCLK_TMU_GPU, "pclk_tmu_gpu", "aclk66_psgen",
>   			GATE_IP_PERIS, 22, 0, 0),
>
> +	GATE(CLK_PCLK_GSCL0, "pclk_gscl0", "dout_gscl_blk_300",
> +			GATE_IP_GSCL0, 14, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_GSCL1, "pclk_gscl1", "dout_gscl_blk_300",
> +			GATE_IP_GSCL0, 15, CLK_IGNORE_UNUSED, 0),
>   	GATE(CLK_ACLK_GSCL0, "aclk_gscl0", "mout_user_aclk300_gscl",
>   			GATE_IP_GSCL0, 0, 0, 0),
>   	GATE(CLK_ACLK_GSCL1, "aclk_gscl1", "mout_user_aclk300_gscl",
>   			GATE_IP_GSCL0, 1, 0, 0),
>   	GATE(CLK_ACLK_FIMC_3AA, "aclk_fimc_3aa", "aclk333_432_gscl",
>   			GATE_IP_GSCL0, 4, 0, 0),
> +	GATE(CLK_PCLK_FIMC_3AA, "pclk_fimc_3aa", "dout_gscl_blk_333",
> +			GATE_IP_GSCL0, 9, 0, 0),
>
>   	GATE(CLK_SMMU_3AA, "smmu_3aa", "dout_gscl_blk_333",
>   			GATE_IP_GSCL1, 2, 0, 0),
> @@ -818,9 +943,13 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   			GATE_BUS_DISP1, 19, 0, 0),
>   	GATE(CLK_SMMU_FIMD1M0, "smmu_fimd1m0", "dout_disp1_blk",
>   			GATE_IP_DISP1, 7, 0, 0),
> +	GATE(CLK_SMMU_FIMD1M1, "smmu_fimd1m1", "dout_disp1_blk",
> +			GATE_IP_DISP1, 8, 0, 0),
>
>   	GATE(CLK_ACLK_MFC, "aclk_mfc", "mout_user_aclk333",
>   			GATE_BUS_MFC, 0, 0, 0),
> +	GATE(CLK_PCLK_MFC, "pclk_mfc", "dout_mfc_blk",
> +			GATE_BUS_MFC, 16, CLK_IGNORE_UNUSED, 0),
>   	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "dout_mfc_blk", GATE_IP_MFC, 1, 0, 0),
>   	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "dout_mfc_blk", GATE_IP_MFC, 2, 0, 0),
>   	GATE(CLK_G3D, "clk_g3d", "mout_user_aclk_g3d",
> @@ -828,14 +957,24 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>
>   	GATE(CLK_ACLK_ROTATOR, "aclk_rotator", "mout_user_aclk266",
>   			GATE_IP_GEN, 1, 0, 0),
> +	GATE(CLK_PCLK_ROTATOR, "pclk_rotator", "dout_gen_blk",
> +			GATE_BUS_GEN, 13, 0, 0),
>   	GATE(CLK_ACLK_JPEG, "aclk_jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
>   	GATE(CLK_ACLK_JPEG2, "aclk_jpeg2", "aclk300_jpeg",
>   			GATE_IP_GEN, 3, 0, 0),
> +	GATE(CLK_ACLK_MDMA0, "aclk_mdma0", "aclk266_g2d",
> +			GATE_BUS_G2D, 1, CLK_IGNORE_UNUSED, 0),
>   	GATE(CLK_ACLK_MDMA1, "aclk_mdma1", "mout_user_aclk266",
>   			GATE_IP_GEN, 4, 0, 0),
>   	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "dout_gen_blk",
>   			GATE_IP_GEN, 6, 0, 0),
> +	GATE(CLK_ACLK_SMMU_MDMA0, "aclk_smmu_mdma0", "aclk266_g2d",
> +			GATE_BUS_G2D, 5, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_SMMU_MDMA0, "smmu_mdma0", "aclk266_g2d",
> +			GATE_BUS_G2D, 20, CLK_IGNORE_UNUSED, 0),
>   	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "dout_jpg_blk", GATE_IP_GEN, 7, 0, 0),
> +	GATE(CLK_SMMU_JPEG2, "smmu_jpeg2", "dout_jpg_blk",
> +			GATE_BUS_GEN, 28, 0, 0),
>   	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "dout_gen_blk",
>   			GATE_IP_GEN, 9, 0, 0),
>
> @@ -845,14 +984,92 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   			GATE_BUS_MSCL, 1, 0, 0),
>   	GATE(CLK_ACLK_MSCL2, "aclk_mscl2", "aclk400_mscl",
>   			GATE_BUS_MSCL, 2, 0, 0),
> +	GATE(CLK_PCLK_MSCL0, "pclk_mscl0", "dout_mscl_blk",
> +			GATE_BUS_MSCL, 8, 0, 0),
> +	GATE(CLK_PCLK_MSCL1, "pclk_mscl1", "dout_mscl_blk",
> +			GATE_BUS_MSCL, 9, 0, 0),
> +	GATE(CLK_PCLK_MSCL2, "pclk_mscl2", "dout_mscl_blk",
> +			GATE_BUS_MSCL, 10, 0, 0),
>   	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "dout_mscl_blk",
>   			GATE_IP_MSCL, 8, 0, 0),
>   	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "dout_mscl_blk",
>   			GATE_IP_MSCL, 9, 0, 0),
>   	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "dout_mscl_blk",
>   			GATE_IP_MSCL, 10, 0, 0),
> -	GATE(CLK_SMMU_MIXER, "smmu_mixer", "dout_disp1_blk",
> -			GATE_IP_DISP1, 9, 0, 0),
> +	GATE(CLK_ACLK_SMMU_MIXER, "aclk_smmu_mixer", "aclk200_disp1",
> +			GATE_BUS_DISP1, 9, CLK_IGNORE_UNUSED, 0),
> +
> +	/* aclk333 gates internal MFC busses and should not be gated. */
> +	/* aclk266 also gates other IPs in psgen. It should not be gated. */
> +	GATE(CLK_ACLK266, "aclk266", "mout_user_aclk266",
> +			GATE_BUS_NOC, 22, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK200_DISP1, "aclk200_disp1", "mout_aclk200_disp1",
> +			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
> +	/* gating of aclk300_gscl causes system hang. It should not be gated. */
> +	GATE(CLK_ACLK400_MSCL, "aclk400_mscl", "mout_user_aclk400_mscl",
> +			GATE_BUS_TOP, 17, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK300_DISP1, "aclk300_disp1", "mout_user_aclk300_disp1",
> +			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK266_ISP, "aclk266_isp", "mout_user_aclk266_isp",
> +			GATE_BUS_TOP, 13, 0, 0),
> +	GATE(CLK_ACLK400_ISP, "aclk400_isp", "mout_user_aclk400_isp",
> +			GATE_BUS_TOP, 16, 0, 0),
> +	GATE(CLK_ACLK333_432_ISP0, "aclk333_432_isp0",
> +			"mout_user_aclk333_432_isp0", GATE_BUS_TOP, 5, 0, 0),
> +	GATE(CLK_ACLK333_432_ISP, "aclk333_432_isp",
> +			"mout_user_aclk333_432_isp", GATE_BUS_TOP, 8, 0, 0),
> +	/* misc: mct, adc, chipid, wdt, rtc, sysreg etc */
> +	GATE(CLK_PCLK_MC, "pclk_mc", "aclk66_psgen", GATE_BUS_GEN, 12, 0, 0),
> +	GATE(CLK_PCLK_TOP_RTC, "pclk_top_rtc", "aclk66_psgen",
> +			GATE_IP_GEN, 5, 0, 0),
> +	GATE(CLK_SCLK_HSIC_12M, "sclk_hsic_12m", "ffactor_hsic_12m",
> +			GATE_BUS_TOP, 29, 0, 0),
> +	GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
> +			GATE_BUS_TOP, 28, 0, 0),
> +	/*
> +	* HACK: When aclk_fimd1 is gated, aclk300_disp1 also gets gated as
> +	* aclk_fimd1 is the only child node. aclk300_disp1 is connected
> +	* to hdmi, mixer IPs through internal busses. gating of aclk300_disp1
> +	* breaks HDMI S2R.
> +	*/
> +	GATE(CLK_PCLK_HDMIPHY, "pclk_hdmiphy", "dout_disp1_blk",
> +			GATE_BUS_DISP1, 15, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_SCLK_MPHY_REFCLK, "sclk_mphy_refclk", "dout_mphy_refclk",
> +			GATE_BUS_TOP, 30, 0, 0),
> +	GATE(CLK_ACLK_FIMC_LITE0, "aclk_fimc_lite0", "aclk333_432_gscl",
> +			GATE_IP_GSCL0, 5, 0, 0),
> +	GATE(CLK_ACLK_FIMC_LITE1, "aclk_fimc_lite1", "aclk333_432_gscl",
> +			GATE_IP_GSCL0, 6, 0, 0),
> +	GATE(CLK_PCLK_FIMC_LITE0, "pclk_fimc_lite0", "dout_gscl_blk_333",
> +			GATE_IP_GSCL0, 10, 0, 0),
> +	GATE(CLK_PCLK_FIMC_LITE1, "pclk_fimc_lite1", "dout_gscl_blk_333",
> +			GATE_IP_GSCL0, 11, 0, 0),
> +	GATE(CLK_PCLK_FIMC_LITE3, "pclk_fimc_lite3", "dout_gscl_blk_333",
> +			GATE_BUS_GSCL0, 13, 0, 0),
> +	/* g2d */
> +	GATE(CLK_ACLK_G2D, "aclk_g2d", "aclk333_g2d",
> +			GATE_BUS_G2D, 3, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_G2D, "pclk_g2d", "aclk266_g2d",
> +			GATE_BUS_G2D, 19, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_SMMU_G2D, "aclk_smmu_g2d", "aclk333_g2d",
> +			GATE_BUS_G2D, 7, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_SMMU_G2D, "smmu_g2d", "aclk266_g2d",
> +			GATE_BUS_G2D, 22, CLK_IGNORE_UNUSED, 0),
> +	/* ISP */
> +	GATE(CLK_SCLK_PWM_ISP, "sclk_pwm_isp", "dout_pwm_isp",
> +			GATE_TOP_SCLK_ISP, 3, 0, 0),
> +	GATE(CLK_SCLK_UART_ISP, "sclk_uart_isp", "dout_uart_isp",
> +			GATE_TOP_SCLK_ISP, 0, 0, 0),
> +	GATE(CLK_SCLK_SPI0_ISP, "sclk_spi0_isp", "dout_spi0_isp_pre",
> +			GATE_TOP_SCLK_ISP, 1, 0, 0),
> +	GATE(CLK_SCLK_SPI1_ISP, "sclk_spi1_isp", "dout_spi1_isp_pre",
> +			GATE_TOP_SCLK_ISP, 2, 0, 0),
> +	GATE(CLK_SCLK_ISP_SENSOR0, "sclk_isp_sensor0", "dout_isp_sensor0",
> +			GATE_TOP_SCLK_ISP, 4, 0, 0),
> +	GATE(CLK_SCLK_ISP_SENSOR1, "sclk_isp_sensor1", "dout_isp_sensor1",
> +			GATE_TOP_SCLK_ISP, 8, 0, 0),
> +	GATE(CLK_SCLK_ISP_SENSOR2, "sclk_isp_sensor2", "dout_isp_sensor2",
> +			GATE_TOP_SCLK_ISP, 12, 0, 0),
>
>   	/* SSS */
>   	GATE(CLK_ACLK_SSS, "aclk_sss", "aclk266_g2d", GATE_IP_G2D, 2, 0, 0),
>

This is really hard to review. May I ask you to split it into separate 
patch adding clocks for each block mentioned in description, please?

Also, as I mentioned in my comments to patches 1/7 and 2/7, respective 
IDs and registers being added should be in respective patches.

Best regards,
Tomasz
