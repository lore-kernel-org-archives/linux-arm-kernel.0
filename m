From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 18:25:55 +0100
Subject: [PATCH v1 3/4] clk: rockchip: rk3288: add CLK_IGNORE_UNUSED flag
 for some clks
In-Reply-To: <1489653894-2440-4-git-send-email-zhangqing@rock-chips.com>
References: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
 <1489653894-2440-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <13427615.tasOxoXEk7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Donnerstag, 16. M?rz 2017, 16:44:53 CET schrieb Elaine Zhang:

much the same comments apply.

Need justification, use critical clocks and things like efuse should
have a driver, so why do they need special handling?


Thanks
Heiko

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 42 +++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 68ba7d4105e7..5a399ba3820a 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -292,17 +292,17 @@ enum rk3288_plls {
>  	COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", CLK_IGNORE_UNUSED,
>  			RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
>  			RK3288_CLKGATE_CON(12), 6, GFLAGS),
> -	COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
> +	COMPOSITE_NOMUX(0, "atclk", "armclk", CLK_IGNORE_UNUSED,
>  			RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
>  			RK3288_CLKGATE_CON(12), 7, GFLAGS),
>  	COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", CLK_IGNORE_UNUSED,
>  			RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
>  			RK3288_CLKGATE_CON(12), 8, GFLAGS),
> -	GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
> +	GATE(0, "pclk_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(12), 9, GFLAGS),
>  	GATE(0, "cs_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(12), 10, GFLAGS),
> -	GATE(0, "pclk_core_niu", "pclk_dbg_pre", 0,
> +	GATE(0, "pclk_core_niu", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(12), 11, GFLAGS),
>  
>  	GATE(0, "dpll_ddr", "dpll", CLK_IGNORE_UNUSED,
> @@ -329,7 +329,7 @@ enum rk3288_plls {
>  	COMPOSITE_NOMUX_DIVTBL(HCLK_CPU, "hclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
>  			RK3288_CLKSEL_CON(1), 8, 2, DFLAGS, div_hclk_cpu_t,
>  			RK3288_CLKGATE_CON(0), 4, GFLAGS),
> -	GATE(0, "c2c_host", "aclk_cpu_src", 0,
> +	GATE(0, "c2c_host", "aclk_cpu_src", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(13), 8, GFLAGS),
>  	COMPOSITE_NOMUX(SCLK_CRYPTO, "crypto", "aclk_cpu_pre", 0,
>  			RK3288_CLKSEL_CON(26), 6, 2, DFLAGS,
> @@ -373,7 +373,7 @@ enum rk3288_plls {
>  	GATE(SCLK_SPDIF8CH, "sclk_spdif_8ch", "spdif_8ch_mux", CLK_SET_RATE_PARENT,
>  			RK3288_CLKGATE_CON(4), 9, GFLAGS),
>  
> -	GATE(0, "sclk_acc_efuse", "xin24m", 0,
> +	GATE(0, "sclk_acc_efuse", "xin24m", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(0), 12, GFLAGS),
>  
>  	GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
> @@ -626,7 +626,7 @@ enum rk3288_plls {
>  	INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
>  			RK3288_CLKSEL_CON(22), 7, IFLAGS),
>  
> -	GATE(0, "jtag", "ext_jtag", 0,
> +	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(4), 14, GFLAGS),
>  
>  	COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy480m_p, 0,
> @@ -635,7 +635,7 @@ enum rk3288_plls {
>  	COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
>  			RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
>  			RK3288_CLKGATE_CON(3), 6, GFLAGS),
> -	GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
> +	GATE(0, "hsicphy12m_xin12m", "xin12m", CLK_IGNORE_UNUSED,
>  			RK3288_CLKGATE_CON(13), 9, GFLAGS),
>  	DIV(0, "hsicphy12m_usbphy", "sclk_hsicphy480m", 0,
>  			RK3288_CLKSEL_CON(11), 8, 6, DFLAGS),
> @@ -668,14 +668,14 @@ enum rk3288_plls {
>  	GATE(PCLK_TIMER, "pclk_timer", "pclk_cpu", 0, RK3288_CLKGATE_CON(10), 1, GFLAGS),
>  	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_cpu", 0, RK3288_CLKGATE_CON(10), 2, GFLAGS),
>  	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_cpu", 0, RK3288_CLKGATE_CON(10), 3, GFLAGS),
> -	GATE(PCLK_DDRUPCTL0, "pclk_ddrupctl0", "pclk_cpu", 0, RK3288_CLKGATE_CON(10), 14, GFLAGS),
> -	GATE(PCLK_PUBL0, "pclk_publ0", "pclk_cpu", 0, RK3288_CLKGATE_CON(10), 15, GFLAGS),
> -	GATE(PCLK_DDRUPCTL1, "pclk_ddrupctl1", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 0, GFLAGS),
> -	GATE(PCLK_PUBL1, "pclk_publ1", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 1, GFLAGS),
> -	GATE(PCLK_EFUSE1024, "pclk_efuse_1024", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 2, GFLAGS),
> +	GATE(PCLK_DDRUPCTL0, "pclk_ddrupctl0", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 14, GFLAGS),
> +	GATE(PCLK_PUBL0, "pclk_publ0", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 15, GFLAGS),
> +	GATE(PCLK_DDRUPCTL1, "pclk_ddrupctl1", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 0, GFLAGS),
> +	GATE(PCLK_PUBL1, "pclk_publ1", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 1, GFLAGS),
> +	GATE(PCLK_EFUSE1024, "pclk_efuse_1024", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 2, GFLAGS),
>  	GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 3, GFLAGS),
>  	GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
> -	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 10, GFLAGS),
> +	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 10, GFLAGS),
>  	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 11, GFLAGS),
>  
>  	/* ddrctrl [DDR Controller PHY clock] gates */
> @@ -689,7 +689,7 @@ enum rk3288_plls {
>  	/* aclk_peri gates */
>  	GATE(0, "aclk_peri_axi_matrix", "aclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(6), 2, GFLAGS),
>  	GATE(ACLK_DMAC2, "aclk_dmac2", "aclk_peri", 0, RK3288_CLKGATE_CON(6), 3, GFLAGS),
> -	GATE(0, "aclk_peri_niu", "aclk_peri", 0, RK3288_CLKGATE_CON(7), 11, GFLAGS),
> +	GATE(0, "aclk_peri_niu", "aclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 11, GFLAGS),
>  	GATE(ACLK_MMU, "aclk_mmu", "aclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(8), 12, GFLAGS),
>  	GATE(ACLK_GMAC, "aclk_gmac", "aclk_peri", 0, RK3288_CLKGATE_CON(8), 0, GFLAGS),
>  	GATE(HCLK_GPS, "hclk_gps", "aclk_peri", 0, RK3288_CLKGATE_CON(8), 2, GFLAGS),
> @@ -712,7 +712,7 @@ enum rk3288_plls {
>  	GATE(HCLK_SDIO1, "hclk_sdio1", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 5, GFLAGS),
>  	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 6, GFLAGS),
>  	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 7, GFLAGS),
> -	GATE(0, "pmu_hclk_otg0", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 5, GFLAGS),
> +	GATE(0, "pmu_hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(7), 5, GFLAGS),
>  
>  	/* pclk_peri gates */
>  	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(6), 1, GFLAGS),
> @@ -752,12 +752,12 @@ enum rk3288_plls {
>  	GATE(PCLK_GPIO5, "pclk_gpio5", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 5, GFLAGS),
>  	GATE(PCLK_GPIO6, "pclk_gpio6", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 6, GFLAGS),
>  	GATE(PCLK_GRF, "pclk_grf", "pclk_pd_alive", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(14), 11, GFLAGS),
> -	GATE(0, "pclk_alive_niu", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 12, GFLAGS),
> +	GATE(0, "pclk_alive_niu", "pclk_pd_alive", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(14), 12, GFLAGS),
>  
>  	/* pclk_pd_pmu gates */
>  	GATE(PCLK_PMU, "pclk_pmu", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 0, GFLAGS),
>  	GATE(0, "pclk_intmem1", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 1, GFLAGS),
> -	GATE(0, "pclk_pmu_niu", "pclk_pd_pmu", 0, RK3288_CLKGATE_CON(17), 2, GFLAGS),
> +	GATE(0, "pclk_pmu_niu", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 2, GFLAGS),
>  	GATE(PCLK_SGRF, "pclk_sgrf", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 3, GFLAGS),
>  	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_pd_pmu", 0, RK3288_CLKGATE_CON(17), 4, GFLAGS),
>  
> @@ -766,7 +766,7 @@ enum rk3288_plls {
>  	GATE(HCLK_VOP0, "hclk_vop0", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 6, GFLAGS),
>  	GATE(HCLK_VOP1, "hclk_vop1", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 8, GFLAGS),
>  	GATE(HCLK_VIO_AHB_ARBI, "hclk_vio_ahb_arbi", "hclk_vio", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 9, GFLAGS),
> -	GATE(HCLK_VIO_NIU, "hclk_vio_niu", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 10, GFLAGS),
> +	GATE(HCLK_VIO_NIU, "hclk_vio_niu", "hclk_vio", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 10, GFLAGS),
>  	GATE(HCLK_VIP, "hclk_vip", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 15, GFLAGS),
>  	GATE(HCLK_IEP, "hclk_iep", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 3, GFLAGS),
>  	GATE(HCLK_ISP, "hclk_isp", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 1, GFLAGS),
> @@ -782,17 +782,17 @@ enum rk3288_plls {
>  	/* aclk_vio0 gates */
>  	GATE(ACLK_VOP0, "aclk_vop0", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 5, GFLAGS),
>  	GATE(ACLK_IEP, "aclk_iep", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 2, GFLAGS),
> -	GATE(ACLK_VIO0_NIU, "aclk_vio0_niu", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 11, GFLAGS),
> +	GATE(ACLK_VIO0_NIU, "aclk_vio0_niu", "aclk_vio0", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 11, GFLAGS),
>  	GATE(ACLK_VIP, "aclk_vip", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 14, GFLAGS),
>  
>  	/* aclk_vio1 gates */
>  	GATE(ACLK_VOP1, "aclk_vop1", "aclk_vio1", 0, RK3288_CLKGATE_CON(15), 7, GFLAGS),
>  	GATE(ACLK_ISP, "aclk_isp", "aclk_vio1", 0, RK3288_CLKGATE_CON(16), 2, GFLAGS),
> -	GATE(ACLK_VIO1_NIU, "aclk_vio1_niu", "aclk_vio1", 0, RK3288_CLKGATE_CON(15), 12, GFLAGS),
> +	GATE(ACLK_VIO1_NIU, "aclk_vio1_niu", "aclk_vio1", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 12, GFLAGS),
>  
>  	/* aclk_rga_pre gates */
>  	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0, RK3288_CLKGATE_CON(15), 0, GFLAGS),
> -	GATE(ACLK_RGA_NIU, "aclk_rga_niu", "aclk_rga_pre", 0, RK3288_CLKGATE_CON(15), 13, GFLAGS),
> +	GATE(ACLK_RGA_NIU, "aclk_rga_niu", "aclk_rga_pre", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 13, GFLAGS),
>  
>  	/*
>  	 * Other ungrouped clocks.
> 
