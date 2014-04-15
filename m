From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 19:03:01 +0200
Subject: [PATCH v2 3/7] clk: exynos5420: Rename clock IDs
In-Reply-To: <1395918470-16374-4-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
 <1395918470-16374-4-git-send-email-shaik.ameer@samsung.com>
Message-ID: <534D6645.8090603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 27.03.2014 12:07, Shaik Ameer Basha wrote:
> From: Rahul Sharma <rahul.sharma@samsung.com>
>
> This patch renames the clock IDs used for the DT bindings as
> per Exynos5420 datasheet.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5420.c   |  162 +++++++++++++++++---------------
>   include/dt-bindings/clock/exynos5420.h |  138 +++++++++++++--------------
>   2 files changed, 154 insertions(+), 146 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 3d0fb77..1402554 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -544,8 +544,8 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>
>   static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   	/* TODO: Re-verify the CG bits for all the gate clocks */
> -	GATE_A(CLK_MCT, "pclk_st", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0,
> -		"mct"),
> +	GATE_A(CLK_PCLK_MCT, "pclk_st", "aclk66_psgen",
> +			GATE_BUS_PERIS1, 2, 0, 0, "mct"),

Clock IDs should generally match clock names, while this one obviously 
does not. Either you should update both, or... (see below)

>
>   	GATE(0, "aclk200_fsys", "mout_user_aclk200_fsys",
>   			GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
> @@ -643,83 +643,90 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
>   	/* FSYS */
>   	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
> -	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> -	GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> +	GATE(CLK_ACLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> +	GATE(CLK_ACLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
>   	GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
> -	GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
> -	GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
> -	GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
> -	GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
> -	GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
> +	GATE(CLK_ACLK_RTIC, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
> +	GATE(CLK_ACLK_MMC0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
> +	GATE(CLK_ACLK_MMC1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
> +	GATE(CLK_ACLK_MMC2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
> +	GATE(CLK_HCLK_SROMC, "sromc", "aclk200_fsys2",
>   			GATE_BUS_FSYS0, 19, CLK_IGNORE_UNUSED, 0),
> -	GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_BUS_FSYS0, 20, 0, 0),
> -	GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21, 0, 0),
> -	GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28, 0, 0),
> +	GATE(CLK_HCLK_USBH20, "usbh20", "aclk200_fsys",
> +			GATE_BUS_FSYS0, 20, 0, 0),
> +	GATE(CLK_HCLK_USBD300, "usbd300", "aclk200_fsys",
> +			GATE_BUS_FSYS0, 21, 0, 0),
> +	GATE(CLK_HCLK_USBD301, "usbd301", "aclk200_fsys",
> +			GATE_BUS_FSYS0, 28, 0, 0),
>
>   	/* UART */
> -	GATE(CLK_UART0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
> -	GATE(CLK_UART1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
> -	GATE_A(CLK_UART2, "uart2", "aclk66_peric",
> +	GATE(CLK_PCLK_UART0, "uart0", "aclk66_peric", GATE_BUS_PERIC, 4, 0, 0),
> +	GATE(CLK_PCLK_UART1, "uart1", "aclk66_peric", GATE_BUS_PERIC, 5, 0, 0),
> +	GATE_A(CLK_PCLK_UART2, "uart2", "aclk66_peric",
>   		GATE_BUS_PERIC, 6, CLK_IGNORE_UNUSED, 0, "uart2"),
> -	GATE(CLK_UART3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
> +	GATE(CLK_PCLK_UART3, "uart3", "aclk66_peric", GATE_BUS_PERIC, 7, 0, 0),
>   	/* I2C */
> -	GATE(CLK_I2C0, "i2c0", "aclk66_peric", GATE_BUS_PERIC, 9, 0, 0),
> -	GATE(CLK_I2C1, "i2c1", "aclk66_peric", GATE_BUS_PERIC, 10, 0, 0),
> -	GATE(CLK_I2C2, "i2c2", "aclk66_peric", GATE_BUS_PERIC, 11, 0, 0),
> -	GATE(CLK_I2C3, "i2c3", "aclk66_peric", GATE_BUS_PERIC, 12, 0, 0),
> -	GATE(CLK_I2C4, "i2c4", "aclk66_peric", GATE_BUS_PERIC, 13, 0, 0),
> -	GATE(CLK_I2C5, "i2c5", "aclk66_peric", GATE_BUS_PERIC, 14, 0, 0),
> -	GATE(CLK_I2C6, "i2c6", "aclk66_peric", GATE_BUS_PERIC, 15, 0, 0),
> -	GATE(CLK_I2C7, "i2c7", "aclk66_peric", GATE_BUS_PERIC, 16, 0, 0),
> -	GATE(CLK_I2C_HDMI, "i2c_hdmi", "aclk66_peric", GATE_BUS_PERIC, 17, 0,
> -		0),
> -	GATE(CLK_TSADC, "tsadc", "aclk66_peric", GATE_BUS_PERIC, 18, 0, 0),
> +	GATE(CLK_PCLK_I2C0, "i2c0", "aclk66_peric", GATE_BUS_PERIC, 9, 0, 0),
> +	GATE(CLK_PCLK_I2C1, "i2c1", "aclk66_peric", GATE_BUS_PERIC, 10, 0, 0),
> +	GATE(CLK_PCLK_I2C2, "i2c2", "aclk66_peric", GATE_BUS_PERIC, 11, 0, 0),
> +	GATE(CLK_PCLK_I2C3, "i2c3", "aclk66_peric", GATE_BUS_PERIC, 12, 0, 0),
> +	GATE(CLK_PCLK_I2C_HDMI, "i2c_hdmi", "aclk66_peric",
> +			GATE_BUS_PERIC, 17, 0, 0),
> +	GATE(CLK_PCLK_TSADC, "tsadc", "aclk66_peric", GATE_BUS_PERIC, 18, 0, 0),
>   	/* SPI */
> -	GATE(CLK_SPI0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
> -	GATE(CLK_SPI1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
> -	GATE(CLK_SPI2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
> +	GATE(CLK_PCLK_SPI0, "spi0", "aclk66_peric", GATE_BUS_PERIC, 19, 0, 0),
> +	GATE(CLK_PCLK_SPI1, "spi1", "aclk66_peric", GATE_BUS_PERIC, 20, 0, 0),
> +	GATE(CLK_PCLK_SPI2, "spi2", "aclk66_peric", GATE_BUS_PERIC, 21, 0, 0),
>   	GATE(CLK_KEYIF, "keyif", "aclk66_peric", GATE_BUS_PERIC, 22, 0, 0),
>   	/* I2S */
> -	GATE(CLK_I2S1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
> -	GATE(CLK_I2S2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
> +	GATE(CLK_PCLK_I2S1, "i2s1", "aclk66_peric", GATE_BUS_PERIC, 23, 0, 0),
> +	GATE(CLK_PCLK_I2S2, "i2s2", "aclk66_peric", GATE_BUS_PERIC, 24, 0, 0),
>   	/* PCM */
> -	GATE(CLK_PCM1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
> -	GATE(CLK_PCM2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
> +	GATE(CLK_PCLK_PCM1, "pcm1", "aclk66_peric", GATE_BUS_PERIC, 25, 0, 0),
> +	GATE(CLK_PCLK_PCM2, "pcm2", "aclk66_peric", GATE_BUS_PERIC, 26, 0, 0),
>   	/* PWM */
> -	GATE(CLK_PWM, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
> +	GATE(CLK_PCLK_PWM, "pwm", "aclk66_peric", GATE_BUS_PERIC, 27, 0, 0),
>   	/* SPDIF */
> -	GATE(CLK_SPDIF, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
> -
> -	GATE(CLK_I2C8, "i2c8", "aclk66_peric", GATE_BUS_PERIC1, 0, 0, 0),
> -	GATE(CLK_I2C9, "i2c9", "aclk66_peric", GATE_BUS_PERIC1, 1, 0, 0),
> -	GATE(CLK_I2C10, "i2c10", "aclk66_peric", GATE_BUS_PERIC1, 2, 0, 0),
> +	GATE(CLK_PCLK_SPDIF, "spdif", "aclk66_peric", GATE_BUS_PERIC, 29, 0, 0),
>
> -	GATE(CLK_CHIPID, "chipid", "aclk66_psgen",
> +	GATE(CLK_PCLK_CHIPID, "chipid", "aclk66_psgen",
>   			GATE_BUS_PERIS0, 12, CLK_IGNORE_UNUSED, 0),
> -	GATE(CLK_SYSREG, "sysreg", "aclk66_psgen",
> +	GATE(CLK_PCLK_SYSREG, "sysreg", "aclk66_psgen",
>   			GATE_BUS_PERIS0, 13, CLK_IGNORE_UNUSED, 0),
> -	GATE(CLK_TZPC0, "tzpc0", "aclk66_psgen", GATE_BUS_PERIS0, 18, 0, 0),
> -	GATE(CLK_TZPC1, "tzpc1", "aclk66_psgen", GATE_BUS_PERIS0, 19, 0, 0),
> -	GATE(CLK_TZPC2, "tzpc2", "aclk66_psgen", GATE_BUS_PERIS0, 20, 0, 0),
> -	GATE(CLK_TZPC3, "tzpc3", "aclk66_psgen", GATE_BUS_PERIS0, 21, 0, 0),
> -	GATE(CLK_TZPC4, "tzpc4", "aclk66_psgen", GATE_BUS_PERIS0, 22, 0, 0),
> -	GATE(CLK_TZPC5, "tzpc5", "aclk66_psgen", GATE_BUS_PERIS0, 23, 0, 0),
> -	GATE(CLK_TZPC6, "tzpc6", "aclk66_psgen", GATE_BUS_PERIS0, 24, 0, 0),
> -	GATE(CLK_TZPC7, "tzpc7", "aclk66_psgen", GATE_BUS_PERIS0, 25, 0, 0),
> -	GATE(CLK_TZPC8, "tzpc8", "aclk66_psgen", GATE_BUS_PERIS0, 26, 0, 0),
> -	GATE(CLK_TZPC9, "tzpc9", "aclk66_psgen", GATE_BUS_PERIS0, 27, 0, 0),
> +	GATE(CLK_PCLK_TZPC0, "tzpc0", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 18, 0, 0),
> +	GATE(CLK_PCLK_TZPC1, "tzpc1", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 19, 0, 0),
> +	GATE(CLK_PCLK_TZPC2, "tzpc2", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 20, 0, 0),
> +	GATE(CLK_PCLK_TZPC3, "tzpc3", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 21, 0, 0),
> +	GATE(CLK_PCLK_TZPC4, "tzpc4", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 22, 0, 0),
> +	GATE(CLK_PCLK_TZPC5, "tzpc5", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 23, 0, 0),
> +	GATE(CLK_PCLK_TZPC6, "tzpc6", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 24, 0, 0),
> +	GATE(CLK_PCLK_TZPC7, "tzpc7", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 25, 0, 0),
> +	GATE(CLK_PCLK_TZPC8, "tzpc8", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 26, 0, 0),
> +	GATE(CLK_PCLK_TZPC9, "tzpc9", "aclk66_psgen",
> +			GATE_BUS_PERIS0, 27, 0, 0),
>
>   	GATE(CLK_HDMI_CEC, "hdmi_cec", "aclk66_psgen", GATE_BUS_PERIS1, 0, 0,
>   		0),
>   	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
> -	GATE(CLK_WDT, "wdt", "aclk66_psgen", GATE_BUS_PERIS1, 3, 0, 0),
> -	GATE(CLK_RTC, "rtc", "aclk66_psgen", GATE_BUS_PERIS1, 4, 0, 0),
> -	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
> -	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_BUS_PERIS1, 6, 0, 0),
> +	GATE(CLK_PCLK_WDT, "wdt", "aclk66_psgen", GATE_BUS_PERIS1, 3, 0, 0),
> +	GATE(CLK_PCLK_RTC, "rtc", "aclk66_psgen", GATE_BUS_PERIS1, 4, 0, 0),
> +	GATE(CLK_PCLK_TMU, "tmu", "aclk66_psgen", GATE_BUS_PERIS1, 5, 0, 0),
> +	GATE(CLK_PCLK_TMU_GPU, "tmu_gpu", "aclk66_psgen",
> +			GATE_BUS_PERIS1, 6, 0, 0),
>

I'm starting to suspect that there is something wrong with this driver. 
Why does it use GATE_BUS_* registers? I believe they provide too fine 
grained control over clocks to suit expectations of our drivers, which 
usually need one "bus clock" gate and optionally one "special clock" gate.

The problem with GATE_BUS_* bits is that they provide control over every 
single clock of over single IP and each IP can have multiple bus clocks 
(e.g. ACLK, PCLK, HCLK, etc.). Gating or ungating one is not enough to 
either properly save power or make the device operable. That's why all 
previous SoCs (Exynos4, Exynos5250) simply used GATE_IP_* registers that 
provide per IP control which matches what our drivers use.

I need to verify this further in datasheet (as soon as I get access to 
one...), but I suspect this is plain wrong.

Now, one side effect of using GATE_IP_* registers will be no need to add 
*CLK_ prefix to clock IDs as they would be simply gating the IPs, not 
their particular clocks.

> -	GATE(CLK_GSCL0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
> -	GATE(CLK_GSCL1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
> -	GATE(CLK_CLK_3AA, "clk_3aa", "aclk300_gscl", GATE_IP_GSCL0, 4, 0, 0),
> +	GATE(CLK_ACLK_GSCL0, "gscl0", "aclk300_gscl", GATE_IP_GSCL0, 0, 0, 0),
> +	GATE(CLK_ACLK_GSCL1, "gscl1", "aclk300_gscl", GATE_IP_GSCL0, 1, 0, 0),
> +	GATE(CLK_ACLK_FIMC_3AA, "clk_3aa", "aclk300_gscl",
> +			GATE_IP_GSCL0, 4, 0, 0),
>
>   	GATE(CLK_SMMU_3AA, "smmu_3aa", "aclk333_432_gscl", GATE_IP_GSCL1, 2, 0,
>   		0),
> @@ -731,38 +738,39 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   		0),
>   	GATE(CLK_SMMU_GSCL1, "smmu_gscl1", "aclk300_gscl", GATE_IP_GSCL1, 7, 0,
>   		0),
> -	GATE(CLK_GSCL_WA, "gscl_wa", "aclk300_gscl", GATE_IP_GSCL1, 12, 0, 0),
> +	GATE(CLK_PCLK_GSCL_WA, "gscl_wa", "aclk300_gscl",
> +			GATE_IP_GSCL1, 12, 0, 0),
>   	GATE(CLK_GSCL_WB, "gscl_wb", "aclk300_gscl", GATE_IP_GSCL1, 13, 0, 0),
>   	GATE(CLK_SMMU_FIMCL3, "smmu_fimcl3,", "aclk333_432_gscl",
>   			GATE_IP_GSCL1, 16, 0, 0),
> -	GATE(CLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
> +	GATE(CLK_ACLK_FIMC_LITE3, "fimc_lite3", "aclk333_432_gscl",
>   			GATE_IP_GSCL1, 17, 0, 0),
>
> -	GATE(CLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
> -	GATE(CLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
> -	GATE(CLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
> -	GATE(CLK_MIXER, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
> -	GATE(CLK_HDMI, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
> -	GATE(CLK_SMMU_FIMD1, "smmu_fimd1", "aclk300_disp1", GATE_IP_DISP1, 8, 0,
> -		0),
> +	GATE(CLK_ACLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
> +	GATE(CLK_PCLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
> +	GATE(CLK_PCLK_DP1, "dp1", "aclk200_disp1", GATE_IP_DISP1, 4, 0, 0),
> +	GATE(CLK_ACLK_MIXER, "mixer", "aclk166", GATE_IP_DISP1, 5, 0, 0),
> +	GATE(CLK_PCLK_HDMI, "hdmi", "aclk200_disp1", GATE_IP_DISP1, 6, 0, 0),
> +	GATE(CLK_SMMU_FIMD1M0, "smmu_fimd1", "aclk300_disp1",
> +			GATE_IP_DISP1, 8, 0, 0),
>
> -	GATE(CLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
> +	GATE(CLK_ACLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
>   	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
>   	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
>
>   	GATE(CLK_G3D, "g3d", "aclkg3d", GATE_IP_G3D, 9, 0, 0),
>
> -	GATE(CLK_ROTATOR, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
> -	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
> -	GATE(CLK_JPEG2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
> -	GATE(CLK_MDMA1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
> +	GATE(CLK_ACLK_ROTATOR, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
> +	GATE(CLK_ACLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
> +	GATE(CLK_ACLK_JPEG2, "jpeg2", "aclk300_jpeg", GATE_IP_GEN, 3, 0, 0),
> +	GATE(CLK_ACLK_MDMA1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
>   	GATE(CLK_SMMU_ROTATOR, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0, 0),
>   	GATE(CLK_SMMU_JPEG, "smmu_jpeg", "aclk300_jpeg", GATE_IP_GEN, 7, 0, 0),
>   	GATE(CLK_SMMU_MDMA1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
>
> -	GATE(CLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
> -	GATE(CLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
> -	GATE(CLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
> +	GATE(CLK_ACLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
> +	GATE(CLK_ACLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
> +	GATE(CLK_ACLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
>   	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0,
>   		0),
>   	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0,
> @@ -773,7 +781,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>   		0),
>
>   	/* SSS */
> -	GATE(CLK_SSS, "sss", "aclk266_g2d", GATE_IP_G2D, 2, 0, 0),
> +	GATE(CLK_ACLK_SSS, "aclk_sss", "aclk266_g2d", GATE_IP_G2D, 2, 0, 0),
>   };
>
>   static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index e921913..598eb48 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -71,120 +71,120 @@
>
>   /* gate clocks */
>   #define CLK_ACLK66_PERIC	256
> -#define CLK_UART0		257
> -#define CLK_UART1		258
> -#define CLK_UART2		259
> -#define CLK_UART3		260
> -#define CLK_I2C0		261
> -#define CLK_I2C1		262
> -#define CLK_I2C2		263
> -#define CLK_I2C3		264
> +#define CLK_PCLK_UART0		257
> +#define CLK_PCLK_UART1		258
> +#define CLK_PCLK_UART2		259
> +#define CLK_PCLK_UART3		260
> +#define CLK_PCLK_I2C0		261
> +#define CLK_PCLK_I2C1		262
> +#define CLK_PCLK_I2C2		263
> +#define CLK_PCLK_I2C3		264
>   #define CLK_I2C4		265
>   #define CLK_I2C5		266
>   #define CLK_I2C6		267
>   #define CLK_I2C7		268
> -#define CLK_I2C_HDMI		269
> -#define CLK_TSADC		270
> -#define CLK_SPI0		271
> -#define CLK_SPI1		272
> -#define CLK_SPI2		273
> +#define CLK_PCLK_I2C_HDMI	269
> +#define CLK_PCLK_TSADC		270
> +#define CLK_PCLK_SPI0		271
> +#define CLK_PCLK_SPI1		272
> +#define CLK_PCLK_SPI2		273
>   #define CLK_KEYIF		274
> -#define CLK_I2S1		275
> -#define CLK_I2S2		276
> -#define CLK_PCM1		277
> -#define CLK_PCM2		278
> -#define CLK_PWM			279
> -#define CLK_SPDIF		280
> +#define CLK_PCLK_I2S1		275
> +#define CLK_PCLK_I2S2		276
> +#define CLK_PCLK_PCM1		277
> +#define CLK_PCLK_PCM2		278
> +#define CLK_PCLK_PWM		279
> +#define CLK_PCLK_SPDIF		280
>   #define CLK_I2C8		281
>   #define CLK_I2C9		282
>   #define CLK_I2C10		283
>   #define CLK_ACLK66_PSGEN	300
> -#define CLK_CHIPID		301
> -#define CLK_SYSREG		302
> -#define CLK_TZPC0		303
> -#define CLK_TZPC1		304
> -#define CLK_TZPC2		305
> -#define CLK_TZPC3		306
> -#define CLK_TZPC4		307
> -#define CLK_TZPC5		308
> -#define CLK_TZPC6		309
> -#define CLK_TZPC7		310
> -#define CLK_TZPC8		311
> -#define CLK_TZPC9		312
> +#define CLK_PCLK_CHIPID		301
> +#define CLK_PCLK_SYSREG		302
> +#define CLK_PCLK_TZPC0		303
> +#define CLK_PCLK_TZPC1		304
> +#define CLK_PCLK_TZPC2		305
> +#define CLK_PCLK_TZPC3		306
> +#define CLK_PCLK_TZPC4		307
> +#define CLK_PCLK_TZPC5		308
> +#define CLK_PCLK_TZPC6		309
> +#define CLK_PCLK_TZPC7		310
> +#define CLK_PCLK_TZPC8		311
> +#define CLK_PCLK_TZPC9		312
>   #define CLK_HDMI_CEC		313
>   #define CLK_SECKEY		314
> -#define CLK_MCT			315
> -#define CLK_WDT			316
> -#define CLK_RTC			317
> -#define CLK_TMU			318
> -#define CLK_TMU_GPU		319
> +#define CLK_PCLK_MCT		315
> +#define CLK_PCLK_WDT		316
> +#define CLK_PCLK_RTC		317
> +#define CLK_PCLK_TMU		318
> +#define CLK_PCLK_TMU_GPU	319
>   #define CLK_PCLK66_GPIO		330
>   #define CLK_ACLK200_FSYS2	350
> -#define CLK_MMC0		351
> -#define CLK_MMC1		352
> -#define CLK_MMC2		353
> -#define CLK_SROMC		354
> +#define CLK_ACLK_MMC0		351
> +#define CLK_ACLK_MMC1		352
> +#define CLK_ACLK_MMC2		353
> +#define CLK_HCLK_SROMC		354
>   #define CLK_UFS			355
>   #define CLK_ACLK200_FSYS	360
>   #define CLK_TSI			361
> -#define CLK_PDMA0		362
> -#define CLK_PDMA1		363
> -#define CLK_RTIC		364
> -#define CLK_USBH20		365
> -#define CLK_USBD300		366
> -#define CLK_USBD301		367
> +#define CLK_ACLK_PDMA0		362
> +#define CLK_ACLK_PDMA1		363
> +#define CLK_ACLK_RTIC		364
> +#define CLK_HCLK_USBH20		365
> +#define CLK_HCLK_USBD300	366
> +#define CLK_HCLK_USBD301	367
>   #define CLK_PCLK200_FSYS	370
>   #define CLK_ACLK400_MSCL	380
> -#define CLK_MSCL0		381
> -#define CLK_MSCL1		382
> -#define CLK_MSCL2		383
> +#define CLK_ACLK_MSCL0		381
> +#define CLK_ACLK_MSCL1		382
> +#define CLK_ACLK_MSCL2		383
>   #define CLK_SMMU_MSCL0		384
>   #define CLK_SMMU_MSCL1		385
>   #define CLK_SMMU_MSCL2		386
>   #define CLK_ACLK333		400
> -#define CLK_MFC			401
> +#define CLK_ACLK_MFC		401
>   #define CLK_SMMU_MFCL		402
>   #define CLK_SMMU_MFCR		403
>   #define CLK_ACLK200_DISP1	410
> -#define CLK_DSIM1		411
> -#define CLK_DP1			412
> -#define CLK_HDMI		413
> +#define CLK_PCLK_DSIM1		411
> +#define CLK_PCLK_DP1		412
> +#define CLK_PCLK_HDMI		413
>   #define CLK_ACLK300_DISP1	420
> -#define CLK_FIMD1		421
> -#define CLK_SMMU_FIMD1		422
> +#define CLK_ACLK_FIMD1		421
> +#define CLK_SMMU_FIMD1M0	422
>   #define CLK_SMMU_FIMD1M1	423
>   #define CLK_ACLK400_DISP1	424
>   #define CLK_ACLK166		430
> -#define CLK_MIXER		431
> +#define CLK_ACLK_MIXER		431
>   #define CLK_ACLK266		440
> -#define CLK_ROTATOR		441
> -#define CLK_MDMA1		442
> +#define CLK_ACLK_ROTATOR	441
> +#define CLK_ACLK_MDMA1		442
>   #define CLK_SMMU_ROTATOR	443
>   #define CLK_SMMU_MDMA1		444
>   #define CLK_ACLK300_JPEG	450
> -#define CLK_JPEG		451
> -#define CLK_JPEG2		452
> +#define CLK_ACLK_JPEG		451
> +#define CLK_ACLK_JPEG2		452
>   #define CLK_SMMU_JPEG		453
>   #define CLK_ACLK300_GSCL	460
>   #define CLK_SMMU_GSCL0		461
>   #define CLK_SMMU_GSCL1		462
> -#define CLK_GSCL_WA		463
> +#define CLK_PCLK_GSCL_WA	463
>   #define CLK_GSCL_WB		464
> -#define CLK_GSCL0		465
> -#define CLK_GSCL1		466
> -#define CLK_CLK_3AA		467
> +#define CLK_ACLK_GSCL0		465
> +#define CLK_ACLK_GSCL1		466
> +#define CLK_ACLK_FIMC_3AA	467
>   #define CLK_ACLK266_G2D		470
> -#define CLK_SSS			471
> -#define CLK_SLIM_SSS		472
> -#define CLK_MDMA0		473
> +#define CLK_ACLK_SSS		471
> +#define CLK_ACLK_SLIM_SSS	472
> +#define CLK_ACLK_MDMA0		473
>   #define CLK_ACLK333_G2D		480
> -#define CLK_G2D			481
> +#define CLK_ACLK_G2D		481
>   #define CLK_ACLK333_432_GSCL	490
>   #define CLK_SMMU_3AA		491
>   #define CLK_SMMU_FIMCL0		492
>   #define CLK_SMMU_FIMCL1		493
>   #define CLK_SMMU_FIMCL3		494
> -#define CLK_FIMC_LITE3		495
> +#define CLK_ACLK_FIMC_LITE3	495
>   #define CLK_G3D			500
>   #define CLK_SMMU_MIXER		502
>   #define CLK_PCLK_TZPC10		503
>

As Gerhard already mentioned, this will break bisection of existing 
users of old macros, so this is a bad idea to change them this way.

Anyway, most of those renames are mostly adding *CLK_ prefixes, so I 
really wonder if this is necessary, especially considering the 
GATE_BUS_* issue I mentioned above and that clock names (and parent 
names in all their children) would have to be updated as well. What do 
you think?

Best regards,
Tomasz
