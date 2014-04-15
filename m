From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 18:43:20 +0200
Subject: [PATCH] clk: exynos4: Use single clock ID for CLK_MDMA gate clocks
In-Reply-To: <1397579420-18776-1-git-send-email-s.nawrocki@samsung.com>
References: <1397579420-18776-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <534D61A8.9090204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 15.04.2014 18:30, Sylwester Nawrocki wrote:
> Exynos4210 and Exynos4x12 SoCs have the PL330 MDMA IP block clock
> defined exactly in same way in documentation. Using different
> names for these clocks is a bit misleading. Since there is no users
> of CLK_MDMA2 in existing dts files this patch drops CLK_MDMA2 and
> replaces it with CLK_MDMA in the driver. This ensures PL330 MDMA
> has correct clock assigned on Exynos4x12 SoCs.
>
> Suggested-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos4.c   |    2 +-
>   include/dt-bindings/clock/exynos4.h |    1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index b4f9672..5247caa 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -903,7 +903,7 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
>   	GATE(CLK_AUDSS, "audss", "sclk_epll", E4X12_GATE_IP_MAUDIO, 0, 0, 0),
>   	GATE(CLK_MDNIE0, "mdnie0", "aclk160", GATE_IP_LCD0, 2, 0, 0),
>   	GATE(CLK_ROTATOR, "rotator", "aclk200", E4X12_GATE_IP_IMAGE, 1, 0, 0),
> -	GATE(CLK_MDMA2, "mdma2", "aclk200", E4X12_GATE_IP_IMAGE, 2, 0, 0),
> +	GATE(CLK_MDMA, "mdma", "aclk200", E4X12_GATE_IP_IMAGE, 2, 0, 0),
>   	GATE(CLK_SMMU_MDMA, "smmu_mdma", "aclk200", E4X12_GATE_IP_IMAGE, 5, 0,
>   		0),
>   	GATE(CLK_MIPI_HSI, "mipi_hsi", "aclk133", GATE_IP_FSYS, 10, 0, 0),
> diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
> index 75aff33..3ff13bc 100644
> --- a/include/dt-bindings/clock/exynos4.h
> +++ b/include/dt-bindings/clock/exynos4.h
> @@ -181,7 +181,6 @@
>   #define CLK_KEYIF		347
>   #define CLK_AUDSS		348
>   #define CLK_MIPI_HSI		349 /* Exynos4210 only */
> -#define CLK_MDMA2		350 /* Exynos4210 only */
>   #define CLK_PIXELASYNCM0	351
>   #define CLK_PIXELASYNCM1	352
>   #define CLK_FIMC_LITE0		353 /* Exynos4x12 only */
>

Looks good, will apply. Thanks.

Best regards,
Tomasz
