From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 14:10:43 +0100
Subject: [PATCH v5 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <1394636208-3125-6-git-send-email-rahul.sharma@samsung.com>
References: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
 <1394636208-3125-6-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5321AE53.7050907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.03.2014 15:56, Rahul Sharma wrote:
> Add support for exynos5260 clocks in clock driver.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/clk/samsung/Makefile         |    1 +
>   drivers/clk/samsung/clk-exynos5260.c | 1805 ++++++++++++++++++++++++++++++++++
>   drivers/clk/samsung/clk-exynos5260.h |  448 +++++++++
>   3 files changed, 2254 insertions(+)
>   create mode 100644 drivers/clk/samsung/clk-exynos5260.c
>   create mode 100644 drivers/clk/samsung/clk-exynos5260.h

[snip]

> diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
> new file mode 100644
> index 0000000..f72ad6a
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos5260.c

[snip]

> +struct samsung_gate_clock aud_gate_clks[] __initdata = {
> +	GATE(AUD_CLK_AUD_UART, "clk_aud_uart", "dout_aclk_aud_131",
> +			EN_IP_AUD, 4, 0, 0),
> +	GATE(AUD_CLK_PCM, "clk_pcm", "dout_aclk_aud_131", EN_IP_AUD, 3, 0, 0),
> +	GATE(AUD_CLK_I2S, "clk_i2s", "dout_aclk_aud_131", EN_IP_AUD, 2, 0, 0),
> +	GATE(AUD_CLK_DMAC, "clk_dmac", "dout_aclk_aud_131",
> +			EN_IP_AUD, 1, 0, 0),
> +	GATE(0, "clk_sramc", "dout_aclk_aud_131", EN_IP_AUD, 0, 0, 0),
> +
> +	GATE(AUD_SCLK_AUD_UART, "sclk_aud_uart", "dout_sclk_aud_uart",
> +			EN_SCLK_AUD, 2, CLK_SET_RATE_PARENT, 0),
> +	GATE(AUD_SCLK_PCM, "sclk_aud_pcm", "dout_sclk_aud_pcm",
> +			EN_SCLK_AUD, 1, CLK_SET_RATE_PARENT, 0),
> +	GATE(AUD_SCLK_I2S, "sclk_aud_i2s", "dout_sclk_aud_i2s",
> +			EN_SCLK_AUD, 0, CLK_SET_RATE_PARENT, 0),

Please keep the clocks sorted by the register offsets ascending as well, 
to match the order in UM.

[snip]

> +
> +struct samsung_mux_clock disp_mux_clks[] __initdata = {
> +	MUX(0, "mout_sclk_hdmi_spdif", mout_sclk_hdmi_spdif_p,
> +			MUX_SEL_DISP4, 4, 2),
> +
> +	MUX(0, "mout_sclk_dsim1_tx_clk_esc_clk_user",
> +			mout_sclk_dsim1_tx_clk_esc_clk_user_p,
> +			MUX_SEL_DISP2, 28, 1),

Ditto.

[snip]

> +struct samsung_gate_clock disp_gate_clks[] __initdata = {
> +	GATE(DISP_CLK_SMMU_TV, "clk_smmu3_tv", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 25, 0, 0),
> +	GATE(DISP_CLK_SMMU_FIMD1M1, "clk_smmu3_fimd1m1",
> +			"mout_aclk_disp_222_user",
> +			EN_IP_DISP, 23, 0, 0),
> +	GATE(DISP_CLK_SMMU_FIMD1M0, "clk_smmu3_fimd1m0",
> +			"mout_aclk_disp_222_user",
> +			EN_IP_DISP, 22, 0, 0),
> +	GATE(0, "clk_pixel_mixer", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_pixel_disp", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 12, CLK_IGNORE_UNUSED, 0),
> +	GATE(DISP_CLK_MIXER, "clk_mixer", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 11, 0, 0),
> +	GATE(DISP_CLK_MIPIPHY, "clk_mipi_dphy", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 10, 0, 0),
> +	GATE(DISP_CLK_HDMIPHY, "clk_hdmiphy", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 9, 0, 0),
> +	GATE(DISP_CLK_HDMI, "clk_hdmi", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 8, 0, 0),
> +	GATE(DISP_CLK_FIMD1, "clk_fimd1", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 7, 0, 0),
> +	GATE(DISP_CLK_DSIM1, "clk_dsim1", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 6, 0, 0),
> +	GATE(DISP_CLK_DPPHY, "clk_dptx_phy", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 5, 0, 0),
> +	GATE(DISP_CLK_DP, "clk_dptx_link", "mout_aclk_disp_222_user",
> +			EN_IP_DISP, 4, 0, 0),
> +	GATE(DISP_SCLK_PIXEL, "sclk_hdmi_phy_pixel_clki",
> +			"dout_sclk_hdmi_phy_pixel_clki",
> +			EN_SCLK_DISP0, 29, CLK_SET_RATE_PARENT, 0),
> +	GATE(DISP_MOUT_HDMI_PHY_PIXEL_USER, "sclk_hdmi_link_i_pixel",
> +			"mout_phyclk_hdmi_phy_pixel_clko_user",
> +			EN_SCLK_DISP0, 26, CLK_SET_RATE_PARENT, 0),

Ditto.

[snip]

> +struct samsung_gate_clock fsys_gate_clks[] __initdata = {
> +	GATE(FSYS_CLK_TSI, "clk_tsi", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 20, 0, 0),
> +	GATE(FSYS_CLK_USBLINK, "clk_usblink", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 18, 0, 0),
> +	GATE(FSYS_CLK_USBHOST20, "clk_usbhost20", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 15, 0, 0),
> +	GATE(FSYS_CLK_USBDRD30, "clk_usbdrd30", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 14, 0, 0),
> +	GATE(FSYS_CLK_SROMC, "clk_sromc", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 13, 0, 0),
> +	GATE(FSYS_CLK_PDMA, "clk_pdma", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 9, 0, 0),
> +	GATE(FSYS_CLK_MMC2, "clk_mmc2", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 8, 0, 0),
> +	GATE(FSYS_CLK_MMC1, "clk_mmc1", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 7, 0, 0),
> +	GATE(FSYS_CLK_MMC0, "clk_mmc0", "dout_aclk_fsys_200",
> +			EN_IP_FSYS, 6, 0, 0),
> +	GATE(FSYS_CLK_RTIC, "clk_rtic", "mout_bustop_pll_user",
> +			EN_IP_FSYS_SECURE_RTIC, 11, 0, 0),
> +	GATE(FSYS_CLK_SMMU_RTIC, "clk_smmu_rtic", "mout_bustop_pll_user",
> +			EN_IP_FSYS_SECURE_SMMU_RTIC, 12, 0, 0),
> +	GATE(FSYS_PHYCLK_USBDRD30, "phyclk_usbdrd30_udrd30_phyclock_g",
> +			"mout_phyclk_usbdrd30_phyclock_user",
> +			EN_SCLK_FSYS, 7, 0, 0),
> +	GATE(FSYS_PHYCLK_USBHOST20, "phyclk_usbhost20_phyclock",
> +			"mout_phyclk_usbdrd30_phyclock_user",
> +			EN_SCLK_FSYS, 1, 0, 0),

Ditto.

[snip]

> +struct samsung_gate_clock gscl_gate_clks[] __initdata = {
> +	GATE(GSCL_CLK_PIXEL_GSCL1, "clk_pixel_gscl1", "mout_aclk_gscl_333",
> +			EN_IP_GSCL, 9, 0, 0),
> +	GATE(GSCL_CLK_PIXEL_GSCL0, "clk_pixel_gscl0", "mout_aclk_gscl_333",
> +			EN_IP_GSCL, 8, 0, 0),
> +	GATE(GSCL_CLK_MSCL1, "clk_mscl1", "mout_aclk_gscl_333",
> +			EN_IP_GSCL, 5, 0, 0),
> +	GATE(GSCL_CLK_MSCL0, "clk_mscl0", "mout_aclk_gscl_333",
> +			EN_IP_GSCL, 4, 0, 0),
> +	GATE(GSCL_CLK_GSCL1, "clk_gscl1", "mout_aclk_gscl_333",
> +			EN_IP_GSCL, 3, 0, 0),
> +	GATE(GSCL_CLK_GSCL0, "clk_gscl0", "mout_aclk_gscl_333",
> +			EN_IP_GSCL, 2, 0, 0),
> +	GATE(GSCL_CLK_FIMC_LITE_D, "clk_fimc_lite_d",
> +			"mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 12, 0, 0),
> +	GATE(GSCL_CLK_FIMC_LITE_B, "clk_fimc_lite_b",
> +			"mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 11, 0, 0),
> +	GATE(GSCL_CLK_FIMC_LITE_A, "clk_fimc_lite_a",
> +			"mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 10, 0, 0),
> +	GATE(GSCL_CLK_CSIS1, "clk_csis1", "mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 9, 0, 0),
> +	GATE(GSCL_CLK_CSIS0, "clk_csis0", "mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 8, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_LITE_D, "clk_smmu3_lite_d",
> +			"mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 7, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_LITE_B, "clk_smmu3_lite_b",
> +			"mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 6, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_LITE_A, "clk_smmu3_lite_a",
> +			"mout_aclk_gscl_fimc_user",
> +			EN_IP_GSCL_FIMC, 5, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_GSCL0, "clk_smmu3_gscl0",
> +			"mout_aclk_gscl_333",
> +			EN_IP_GSCL_SECURE_SMMU_GSCL0, 17, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_GSCL1, "clk_smmu3_gscl1", "mout_aclk_gscl_333",
> +			EN_IP_GSCL_SECURE_SMMU_GSCL1, 18, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_MSCL0, "clk_smmu3_mscl0",
> +			"mout_aclk_m2m_400_user",
> +			EN_IP_GSCL_SECURE_SMMU_MSCL0, 19, 0, 0),
> +	GATE(GSCL_CLK_SMMU3_MSCL1, "clk_smmu3_mscl1",
> +			"mout_aclk_m2m_400_user",
> +			EN_IP_GSCL_SECURE_SMMU_MSCL1, 20, 0, 0),
> +	GATE(GSCL_SCLK_CSIS1_WRAP, "sclk_csis1_wrap", "dout_aclk_csis_200",
> +			EN_SCLK_GSCL_FIMC, 1, CLK_SET_RATE_PARENT, 0),
> +	GATE(GSCL_SCLK_CSIS0_WRAP, "sclk_csis0_wrap", "dout_aclk_csis_200",
> +			EN_SCLK_GSCL_FIMC, 0, CLK_SET_RATE_PARENT, 0),

Ditto.

[snip]

> +struct samsung_gate_clock isp_gate_clks[] __initdata = {
> +	GATE(ISP_CLK_GIC, "clk_isp_gic", "mout_aclk_isp1_266",
> +			EN_IP_ISP0, 15, 0, 0),
> +	GATE(ISP_CLK_WDT, "clk_isp_wdt", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 31, 0, 0),
> +	GATE(ISP_CLK_UART, "clk_isp_uart", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 30, 0, 0),
> +	GATE(ISP_CLK_SPI1, "clk_isp_spi1", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 28, 0, 0),
> +	GATE(ISP_CLK_SPI0, "clk_isp_spi0", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 27, 0, 0),
> +	GATE(ISP_CLK_SMMU_SCALERP, "clk_isp_smmu_scalerp",
> +			"mout_aclk_isp1_266",
> +			EN_IP_ISP1, 26, 0, 0),
> +	GATE(ISP_CLK_SMMU_SCALERC, "clk_isp_smmu_scalerc",
> +			"mout_aclk_isp1_266",
> +			EN_IP_ISP1, 25, 0, 0),
> +	GATE(ISP_CLK_SMMU_ISPCX, "clk_smmu_ispcx", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 24, 0, 0),
> +	GATE(ISP_CLK_SMMU_ISP, "clk_smmu_isp", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 23, 0, 0),
> +	GATE(ISP_CLK_SMMU_FD, "clk_smmu_fd", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 22, 0, 0),
> +	GATE(ISP_CLK_SMMU_DRC, "clk_smmu_drc", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 21, 0, 0),
> +	GATE(ISP_CLK_PWM, "clk_isp_pwm", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 14, 0, 0),
> +	GATE(ISP_CLK_MTCADC, "clk_isp_mtcadc", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 11, 0, 0),
> +	GATE(ISP_CLK_MPWM, "clk_isp_mpwm", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 10, 0, 0),
> +	GATE(ISP_CLK_MCUCTL, "clk_isp_mcuctl", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 9, 0, 0),
> +	GATE(ISP_CLK_I2C1, "clk_isp_i2c1", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 8, 0, 0),
> +	GATE(ISP_CLK_I2C0, "clk_isp_i2c0", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 7, 0, 0),
> +	GATE(ISP_CLK_FIMC_SCALERP, "clk_isp_fimc_scalerp",
> +			"mout_aclk_isp1_266",
> +			EN_IP_ISP1, 6, 0, 0),
> +	GATE(ISP_CLK_FIMC_SCALERC, "clk_isp_fimc_scalerc",
> +			"mout_aclk_isp1_266",
> +			EN_IP_ISP1, 5, 0, 0),
> +	GATE(ISP_CLK_FIMC, "clk_isp_fimc", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 4, 0, 0),
> +	GATE(ISP_CLK_FIMC_FD, "clk_isp_fimc_fd", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 3, 0, 0),
> +	GATE(ISP_CLK_FIMC_DRC, "clk_isp_fimc_drc", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 2, 0, 0),
> +	GATE(ISP_CLK_CA5, "clk_isp_ca5", "mout_aclk_isp1_266",
> +			EN_IP_ISP1, 1, 0, 0),
> +	GATE(ISP_SCLK_SPI0_EXT, "sclk_isp_spi0_ext", "fin_pll",
> +			EN_SCLK_ISP, 9, CLK_SET_RATE_PARENT, 0),
> +	GATE(ISP_SCLK_SPI1_EXT, "sclk_isp_spi1_ext", "fin_pll",
> +			EN_SCLK_ISP, 8, CLK_SET_RATE_PARENT, 0),
> +	GATE(ISP_SCLK_UART_EXT, "sclk_isp_uart_ext", "fin_pll",
> +			EN_SCLK_ISP, 7, CLK_SET_RATE_PARENT, 0),

Ditto.

[snip]

> +struct samsung_gate_clock mif_gate_clks[] __initdata = {
> +	GATE(0, "clk_lpddr3phy_wrap1", "dout_clk2x_phy",
> +			EN_IP_MIF, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_lpddr3phy_wrap0", "dout_clk2x_phy",
> +			EN_IP_MIF, 12, CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_monocnt", "dout_aclk_bus_100",
> +			EN_IP_MIF_SECURE_MONOCNT, 22,
> +			CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_mif_rtc", "dout_aclk_bus_100",
> +			EN_IP_MIF_SECURE_RTC_APBIF, 23,
> +			CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_drex1", "dout_aclk_mif_466",
> +			EN_IP_MIF_SECURE_DREX1_TZ, 9,
> +			CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_drex0", "dout_aclk_mif_466",
> +			EN_IP_MIF_SECURE_DREX0_TZ, 9,
> +			CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "clk_intmem", "dout_aclk_bus_200",
> +			EN_IP_MIF_SECURE_INTEMEM, 11,
> +			CLK_IGNORE_UNUSED, 0),
> +	GATE(0, "sclk_lpddr3phy_wrap_u1", "dout_clkm_phy",
> +			EN_SCLK_MIF, 0, CLK_IGNORE_UNUSED |
> +				CLK_SET_RATE_PARENT, 0),
> +	GATE(0, "sclk_lpddr3phy_wrap_u0", "dout_clkm_phy",
> +			EN_SCLK_MIF, 0, CLK_IGNORE_UNUSED |
> +				CLK_SET_RATE_PARENT, 0),

Ditto.

[snip]

> +struct samsung_gate_clock peri_gate_clks[] __initdata = {

[snip]

> +		EN_IP_PERI_SECURE_TZPC, 13, 0, 0),
> +	GATE(PERI_CLK_TZPC2, "clk_tzpc2", "dout_aclk_peri_66",
> +		EN_IP_PERI_SECURE_TZPC, 12, 0, 0),
> +	GATE(PERI_CLK_TZPC1, "clk_tzpc1", "dout_aclk_peri_66",
> +		EN_IP_PERI_SECURE_TZPC, 11, 0, 0),
> +	GATE(PERI_CLK_TZPC0, "clk_tzpc0", "dout_aclk_peri_66",
> +		EN_IP_PERI_SECURE_TZPC, 10, 0, 0),
> +	GATE(PERI_SCLK_UART2, "sclk_uart2", "dout_sclk_peri_uart2",
> +			EN_SCLK_PERI, 12, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_UART1, "sclk_uart1", "dout_sclk_peri_uart1",
> +			EN_SCLK_PERI, 11, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_UART0, "sclk_uart0", "dout_sclk_peri_uart0",
> +			EN_SCLK_PERI, 10, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_SPI2, "sclk_spi2", "dout_sclk_peri_spi2_b",
> +			EN_SCLK_PERI, 9, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_SPI1, "sclk_spi1", "dout_sclk_peri_spi1_b",
> +			EN_SCLK_PERI, 8, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_SPI0, "sclk_spi0", "dout_sclk_peri_spi0_b",
> +			EN_SCLK_PERI, 7, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_SPDIF, "sclk_spdif", "dout_sclk_peri_spi0_b",
> +			EN_SCLK_PERI, 2, CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_I2S, "sclk_i2s", "dout_i2s", EN_SCLK_PERI, 1,
> +			CLK_SET_RATE_PARENT, 0),
> +	GATE(PERI_SCLK_PCM1, "sclk_pcm1", "dout_pcm", EN_SCLK_PERI, 0,
> +			CLK_SET_RATE_PARENT, 0),

Ditto.

[snip]

> +struct samsung_mux_clock top_mux_clks[] __initdata = {
> +	MUX(0, "mout_audtop_pll_user", mout_audtop_pll_user_p,
> +			MUX_SEL_TOP_PLL0, 24, 1),
> +	MUX(0, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP_PLL0, 16, 1),
> +	MUX(TOP_MOUT_DISP_PLL, "mout_disp_pll", mout_disp_pll_p,
> +			MUX_SEL_TOP_PLL0, 12, 1),
> +	MUX(0, "mout_bustop_pll_user", mout_bustop_pll_user_p,
> +			MUX_SEL_TOP_PLL0, 8, 1),
> +	MUX(0, "mout_memtop_pll_user", mout_memtop_pll_user_p,
> +			MUX_SEL_TOP_PLL0, 4, 1),
> +	MUX(0, "mout_mediatop_pll_user", mout_mediatop_pll_user_p,
> +			MUX_SEL_TOP_PLL0, 0, 1),
> +	MUX(0, "mout_disp_disp_333", mout_disp_disp_333_p,
> +			MUX_SEL_TOP_DISP0, 0, 1),
> +	MUX(0, "mout_aclk_disp_333", mout_aclk_disp_333_p,
> +			MUX_SEL_TOP_DISP0, 8, 1),
> +	MUX(0, "mout_disp_disp_222", mout_disp_disp_222_p,
> +			MUX_SEL_TOP_DISP0, 12, 1),
> +	MUX(0, "mout_aclk_disp_222", mout_aclk_disp_222_p,
> +			MUX_SEL_TOP_DISP0, 20, 1),
> +	MUX(0, "mout_disp_media_pixel", mout_disp_media_pixel_p,
> +			MUX_SEL_TOP_DISP1, 8, 1),
> +	MUX(TOP_MOUT_FIMD1, "mout_sclk_disp_pixel", mout_sclk_disp_pixel_p,
> +			MUX_SEL_TOP_DISP1, 0, 1),
> +	MUX(0, "mout_sclk_peri_spi0_clk", mout_sclk_peri_spi_clk_p,
> +			MUX_SEL_TOP_PERI1, 8, 1),
> +	MUX(0, "mout_sclk_peri_spi1_clk", mout_sclk_peri_spi_clk_p,
> +			MUX_SEL_TOP_PERI1, 4, 1),
> +	MUX(0, "mout_sclk_peri_spi2_clk", mout_sclk_peri_spi_clk_p,
> +			MUX_SEL_TOP_PERI1, 0, 1),
> +	MUX(0, "mout_sclk_peri_uart0_uclk", mout_sclk_peri_uart_uclk_p,
> +			MUX_SEL_TOP_PERI1, 20, 1),
> +	MUX(0, "mout_sclk_peri_uart2_uclk", mout_sclk_peri_uart_uclk_p,
> +			MUX_SEL_TOP_PERI1, 16, 1),
> +	MUX(0, "mout_sclk_peri_uart1_uclk", mout_sclk_peri_uart_uclk_p,
> +			MUX_SEL_TOP_PERI1, 12, 1),
> +	MUX(0, "mout_bus4_bustop_100", mout_bus_bustop_100_p,
> +			MUX_SEL_TOP_BUS, 28, 1),
> +	MUX(0, "mout_bus4_bustop_400", mout_bus_bustop_400_p,
> +			MUX_SEL_TOP_BUS, 24, 1),
> +	MUX(0, "mout_bus3_bustop_100", mout_bus_bustop_100_p,
> +			MUX_SEL_TOP_BUS, 20, 1),
> +	MUX(0, "mout_bus3_bustop_400", mout_bus_bustop_400_p,
> +			MUX_SEL_TOP_BUS, 16, 1),
> +	MUX(0, "mout_bus2_bustop_400", mout_bus_bustop_400_p,
> +			MUX_SEL_TOP_BUS, 12, 1),
> +	MUX(0, "mout_bus2_bustop_100", mout_bus_bustop_100_p,
> +			MUX_SEL_TOP_BUS, 8, 1),
> +	MUX(0, "mout_bus1_bustop_100", mout_bus_bustop_100_p,
> +			MUX_SEL_TOP_BUS, 4, 1),
> +	MUX(0, "mout_bus1_bustop_400", mout_bus_bustop_400_p,
> +			MUX_SEL_TOP_BUS, 0, 1),

Ditto.

> +	MUX(0, "mout_sclk_fsys_usb", mout_sclk_fsys_usb_p,
> +			MUX_SEL_TOP_FSYS, 0, 1),
> +	MUX(0, "mout_sclk_fsys_mmc0_sdclkin_a",
> +			mout_sclk_fsys_mmc_sdclkin_a_p,
> +			MUX_SEL_TOP_FSYS, 20, 1),
> +	MUX(0, "mout_sclk_fsys_mmc1_sdclkin_a",
> +			mout_sclk_fsys_mmc_sdclkin_a_p,
> +			MUX_SEL_TOP_FSYS, 12, 1),
> +	MUX(0, "mout_sclk_fsys_mmc2_sdclkin_a",
> +			mout_sclk_fsys_mmc_sdclkin_a_p,
> +			MUX_SEL_TOP_FSYS, 4, 1),
> +	MUX(0, "mout_sclk_fsys_mmc0_sdclkin_b",
> +			mout_sclk_fsys_mmc0_sdclkin_b_p,
> +			MUX_SEL_TOP_FSYS, 24, 1),
> +	MUX(0, "mout_sclk_fsys_mmc1_sdclkin_b",
> +			mout_sclk_fsys_mmc1_sdclkin_b_p,
> +			MUX_SEL_TOP_FSYS, 16, 1),
> +	MUX(0, "mout_sclk_fsys_mmc2_sdclkin_b",
> +			mout_sclk_fsys_mmc2_sdclkin_b_p,
> +			MUX_SEL_TOP_FSYS, 8, 1),
> +	MUX(0, "mout_aclk_isp1_266", mout_aclk_isp1_266_p,
> +			MUX_SEL_TOP_ISP10, 20, 1),
> +	MUX(0, "mout_isp1_media_266", mout_isp1_media_266_p,
> +			MUX_SEL_TOP_ISP10, 16, 1),
> +	MUX(0, "mout_aclk_isp1_400", mout_aclk_isp1_400_p,
> +			MUX_SEL_TOP_ISP10, 8 , 1),
> +	MUX(0, "mout_isp1_media_400", mout_isp1_media_400_p,
> +			MUX_SEL_TOP_ISP10, 4, 1),
> +	MUX(0, "mout_sclk_isp1_spi0", mout_sclk_isp_spi_p,
> +			MUX_SEL_TOP_ISP11, 4, 1),
> +	MUX(0, "mout_sclk_isp1_spi1", mout_sclk_isp_spi_p,
> +			MUX_SEL_TOP_ISP11, 8, 1),
> +	MUX(0, "mout_sclk_isp1_uart", mout_sclk_isp_uart_p,
> +			MUX_SEL_TOP_ISP11, 12, 1),
> +	MUX(0, "mout_sclk_isp1_sensor2", mout_sclk_isp_sensor_p,
> +			MUX_SEL_TOP_ISP11, 24, 1),
> +	MUX(0, "mout_sclk_isp1_sensor1", mout_sclk_isp_sensor_p,
> +			MUX_SEL_TOP_ISP11, 20, 1),
> +	MUX(0, "mout_sclk_isp1_sensor0", mout_sclk_isp_sensor_p,
> +			MUX_SEL_TOP_ISP11, 16, 1),

Ditto.

> +	MUX(0, "mout_aclk_mfc_333", mout_aclk_mfc_333_p,
> +			MUX_SEL_TOP_MFC, 8, 1),
> +	MUX(0, "mout_mfc_bustop_333", mout_mfc_bustop_333_p,
> +			MUX_SEL_TOP_MFC, 4, 1),
> +	MUX(0, "mout_aclk_g2d_333", mout_aclk_g2d_333_p,
> +			MUX_SEL_TOP_G2D, 8, 1),
> +	MUX(0, "mout_g2d_bustop_333", mout_g2d_bustop_333_p,
> +			MUX_SEL_TOP_G2D, 4, 1),
> +	MUX(0, "mout_aclk_gscl_fimc", mout_aclk_gscl_fimc_p,
> +			MUX_SEL_TOP_GSCL, 20, 1),
> +	MUX(0, "mout_gscl_bustop_fimc", mout_gscl_bustop_fimc_p,
> +			MUX_SEL_TOP_GSCL, 16, 1),
> +	MUX(0, "mout_aclk_gscl_333", mout_aclk_gscl_333_p,
> +			MUX_SEL_TOP_GSCL, 12, 1),
> +	MUX(0, "mout_gscl_bustop_333", mout_gscl_bustop_333_p,
> +			MUX_SEL_TOP_GSCL, 8, 1),
> +	MUX(0, "mout_aclk_gscl_400", mout_aclk_gscl_400_p,
> +			MUX_SEL_TOP_GSCL, 4, 1),
> +	MUX(0, "mout_m2m_mediatop_400", mout_m2m_mediatop_400_p,
> +			MUX_SEL_TOP_GSCL, 0, 1),

Ditto.

> +};
> +
> +struct samsung_div_clock top_div_clks[] __initdata = {
> +	DIV(0, "dout_aclk_mfc_333", "mout_aclk_mfc_333",
> +			DIV_TOP_G2D_MFC, 4, 3),
> +	DIV(0, "dout_aclk_g2d_333", "mout_aclk_g2d_333",
> +			DIV_TOP_GSCL_ISP0, 0, 3),

This looks wrong. The register and bit field are the same as 
"dout_aclk_gscl_333" below.

> +	DIV(0, "dout_sclk_isp1_sensor2_a", "mout_aclk_gscl_fimc",
> +			DIV_TOP_GSCL_ISP0, 24, 4),
> +	DIV(0, "dout_sclk_isp1_sensor1_a", "mout_aclk_gscl_400",
> +			DIV_TOP_GSCL_ISP0, 20, 4),
> +	DIV(0, "dout_sclk_isp1_sensor0_a", "mout_aclk_gscl_fimc",
> +			DIV_TOP_GSCL_ISP0, 16, 4),
> +	DIV(0, "dout_aclk_gscl_fimc", "mout_aclk_gscl_fimc",
> +			DIV_TOP_GSCL_ISP0, 8, 3),
> +	DIV(0, "dout_aclk_gscl_400", "mout_aclk_gscl_400",
> +			DIV_TOP_GSCL_ISP0, 4, 3),
> +	DIV(0, "dout_aclk_gscl_333", "mout_aclk_gscl_333",
> +			DIV_TOP_GSCL_ISP0, 0, 3),
> +	DIV(0, "dout_sclk_isp1_spi0_b", "dout_sclk_isp1_spi0_a",
> +			DIV_TOP_ISP10, 16, 8),
> +	DIV(0, "dout_sclk_isp1_spi0_a", "mout_sclk_isp1_spi0",
> +			DIV_TOP_ISP10, 12, 4),
> +	DIV(0, "dout_aclk_isp1_400", "mout_aclk_isp1_400",
> +			DIV_TOP_ISP10, 4, 3),
> +	DIV(0, "dout_aclk_isp1_266", "mout_aclk_isp1_266",
> +			DIV_TOP_ISP10, 0, 3),
> +	DIV(0, "dout_sclk_isp1_uart", "mout_sclk_isp1_uart",
> +			DIV_TOP_ISP11, 12, 4),
> +	DIV(0, "dout_sclk_isp1_spi1_b", "dout_sclk_isp1_spi1_a",
> +			DIV_TOP_ISP11, 4, 8),
> +	DIV(0, "dout_sclk_isp1_spi1_a", "mout_sclk_isp1_spi1",
> +			DIV_TOP_ISP11, 0, 4),
> +	DIV(0, "dout_sclk_isp1_sensor2_b", "dout_sclk_isp1_sensor2_a",
> +			DIV_TOP_ISP11, 24, 4),
> +	DIV(0, "dout_sclk_isp1_sensor1_b", "dout_sclk_isp1_sensor1_a",
> +			DIV_TOP_ISP11, 20, 4),
> +	DIV(0, "dout_sclk_isp1_sensor0_b", "dout_sclk_isp1_sensor0_a",
> +			DIV_TOP_ISP11, 16, 4),
> +	DIV(0, "dout_sclk_hpm_targetclk", "mout_bustop_pll_user",
> +			DIV_TOP_HPM, 0, 3),
> +	DIV(0, "dout_sclk_disp_pixel", "mout_sclk_disp_pixel",
> +			DIV_TOP_DISP, 8, 3),
> +	DIV(0, "dout_aclk_disp_222", "mout_aclk_disp_222",
> +			DIV_TOP_DISP, 4, 3),
> +	DIV(0, "dout_aclk_disp_333", "mout_aclk_disp_333",
> +			DIV_TOP_DISP, 0, 3),

Sorting order.

> +	DIV(0, "dout_aclk_bus4_100", "mout_bus4_bustop_100",
> +			DIV_TOP_BUS, 28, 4),
> +	DIV(0, "dout_aclk_bus4_400", "mout_bus4_bustop_400",
> +			DIV_TOP_BUS, 24, 3),
> +	DIV(0, "dout_aclk_bus3_100", "mout_bus3_bustop_100",
> +			DIV_TOP_BUS, 20, 4),
> +	DIV(0, "dout_aclk_bus3_400", "mout_bus3_bustop_400",
> +			DIV_TOP_BUS, 16, 3),
> +	DIV(0, "dout_aclk_bus2_100", "mout_bus2_bustop_100",
> +			DIV_TOP_BUS, 12, 4),
> +	DIV(0, "dout_aclk_bus2_400", "mout_bus2_bustop_400",
> +			DIV_TOP_BUS, 8, 3),
> +	DIV(0, "dout_aclk_bus1_100", "mout_bus1_bustop_100",
> +			DIV_TOP_BUS, 4, 4),
> +	DIV(0, "dout_aclk_bus1_400", "mout_bus1_bustop_400",
> +			DIV_TOP_BUS, 0, 3),
> +	DIV(0, "dout_sclk_peri_spi1_b", "dout_sclk_peri_spi1_a",
> +			DIV_TOP_PERI0, 20, 8),
> +	DIV(0, "dout_sclk_peri_spi1_a", "mout_sclk_peri_spi1_clk",
> +			DIV_TOP_PERI0, 16, 4),
> +	DIV(0, "dout_sclk_peri_spi0_b", "dout_sclk_peri_spi0_a",
> +			DIV_TOP_PERI0, 8, 8),
> +	DIV(0, "dout_sclk_peri_spi0_a", "mout_sclk_peri_spi0_clk",
> +			DIV_TOP_PERI0, 4, 4),
> +	DIV(0, "dout_sclk_peri_uart0", "mout_sclk_peri_uart0_uclk",
> +			DIV_TOP_PERI1, 24, 4),
> +	DIV(0, "dout_sclk_peri_uart2", "mout_sclk_peri_uart2_uclk",
> +			DIV_TOP_PERI1, 20, 4),
> +	DIV(0, "dout_sclk_peri_uart1", "mout_sclk_peri_uart1_uclk",
> +			DIV_TOP_PERI1, 16, 4),
> +	DIV(0, "dout_sclk_peri_spi2_b", "dout_sclk_peri_spi2_a",
> +			DIV_TOP_PERI1, 4, 8),
> +	DIV(0, "dout_sclk_peri_spi2_a", "mout_sclk_peri_spi2_clk",
> +			DIV_TOP_PERI1, 0, 4),
> +	DIV(0, "dout_aclk_peri_aud", "mout_audtop_pll_user",
> +			DIV_TOP_PERI2, 24, 3),
> +	DIV(0, "dout_aclk_peri_66", "mout_bustop_pll_user",
> +			DIV_TOP_PERI2, 20, 4),
> +	DIV(0, "dout_sclk_fsys_mmc0_sdclkin_b",
> +			"dout_sclk_fsys_mmc0_sdclkin_a",
> +			DIV_TOP_FSYS0, 16, 8),
> +	DIV(0, "dout_sclk_fsys_mmc0_sdclkin_a",
> +			"mout_sclk_fsys_mmc0_sdclkin_b",
> +			DIV_TOP_FSYS0, 12, 4),
> +	DIV(0, "dout_sclk_fsys_usbdrd30_suspend_clk",
> +			"mout_sclk_fsys_usb",
> +			DIV_TOP_FSYS0, 4, 4),
> +	DIV(0, "dout_aclk_fsys_200", "mout_bustop_pll_user",
> +			DIV_TOP_FSYS0, 0, 3),
> +
> +	DIV(0, "dout_sclk_fsys_mmc2_sdclkin_b",
> +			"dout_sclk_fsys_mmc2_sdclkin_a",
> +			DIV_TOP_FSYS1, 16, 8),
> +	DIV(0, "dout_sclk_fsys_mmc2_sdclkin_a",
> +			"mout_sclk_fsys_mmc2_sdclkin_b",
> +			DIV_TOP_FSYS1, 12, 4),
> +	DIV(0, "dout_sclk_fsys_mmc1_sdclkin_b",
> +			"dout_sclk_fsys_mmc1_sdclkin_a",
> +			DIV_TOP_FSYS1, 4, 8),
> +	DIV(0, "dout_sclk_fsys_mmc1_sdclkin_a",
> +			"mout_sclk_fsys_mmc1_sdclkin_b",
> +			DIV_TOP_FSYS1, 0, 4),
> +};
> +
> +struct samsung_gate_clock top_gate_clks[] __initdata = {
> +	GATE(TOP_SCLK_FIMD1, "sclk_disp_pixel", "dout_sclk_disp_pixel",
> +			EN_ACLK_TOP, 10, CLK_IGNORE_UNUSED |
> +			CLK_SET_RATE_PARENT, 0),

Is this the right register? Enabling an SCLK in an ACLK enable register 
seems a bit strange. Could you confirm in the UM?

> +	GATE(TOP_SCLK_MMC2, "sclk_fsys_mmc2_sdclkin",
> +			"dout_sclk_fsys_mmc2_sdclkin_b",
> +			EN_SCLK_TOP, 9, CLK_SET_RATE_PARENT, 0),
> +	GATE(TOP_SCLK_MMC1, "sclk_fsys_mmc1_sdclkin",
> +			"dout_sclk_fsys_mmc1_sdclkin_b",
> +			EN_SCLK_TOP, 8, CLK_SET_RATE_PARENT,
> +			0),
> +	GATE(TOP_SCLK_MMC0, "sclk_fsys_mmc0_sdclkin",
> +			"dout_sclk_fsys_mmc0_sdclkin_b",
> +			EN_SCLK_TOP, 7, CLK_SET_RATE_PARENT, 0),
> +};

[snip]

> diff --git a/drivers/clk/samsung/clk-exynos5260.h b/drivers/clk/samsung/clk-exynos5260.h
> new file mode 100644
> index 0000000..7c3717a
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos5260.h

[snip]

> +#define CLKOUT_CMU_EGL		0x0c00
> +#define CLKOUT_CMU_EGL_DIV_STAT	0x0c04
> +#define ARMCLK_STOPCTRL		0x1000
> +#define EAGLE_EMA_CTRL		0x1008
> +#define EAGLE_EMA_STATUS	0x100c
> +#define PWR_CTRL		0x1020
> +#define PWR_CTRL2		0x1024
> +#define CLKSTOP_CTRL		0x1028
> +#define INTR_SPREAD_EN		0x1080
> +#define INTR_SPREAD_USE_STANDBYWFI	0x1084
> +#define INTR_SPREAD_BLOCKING_DURATION	0x1088

Please align indentation of values to the highest common one.

Best regards,
Tomasz
