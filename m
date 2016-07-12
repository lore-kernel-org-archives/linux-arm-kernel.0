From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 12 Jul 2016 15:17:27 -0700
Subject: [PATCH v3 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag
 from SPI clocks
In-Reply-To: <1468317736-18841-8-git-send-email-andi.shyti@samsung.com>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-8-git-send-email-andi.shyti@samsung.com>
Message-ID: <146836184696.73491.9452469757415968654@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andi Shyti (2016-07-12 03:02:16)
> Because the Exynos5433 SPI driver supports the ioclk handling and
> the following patch:
> 
>   http://marc.info/?l=linux-kernel&m=146787645626318&w=2
> 
> fixes a synchronus abort issue, none of the SPI clocks require
> any critical handling: remove, then, the CLK_IGNORE_UNUSED flag
> for the SPI related clocks.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Do you want these patches to go through same tree? If not, I can take
this patch into clk-next.

Regards,
Mike

> ---
>  drivers/clk/samsung/clk-exynos5433.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index c3a5318..fb19525 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -1661,8 +1661,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
>         GATE(CLK_SCLK_IOCLK_SPI2, "sclk_ioclk_spi2", "ioclk_spi2_clk_in",
>                         ENABLE_SCLK_PERIC, 13, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_IOCLK_SPI1, "sclk_ioclk_spi1", "ioclk_spi1_clk_in",
> -                       ENABLE_SCLK_PERIC, 12,
> -                       CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
> +                       ENABLE_SCLK_PERIC, 12, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_IOCLK_SPI0, "sclk_ioclk_spi0", "ioclk_spi0_clk_in",
>                         ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
> @@ -1677,7 +1676,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
>         GATE(CLK_SCLK_SPI2, "sclk_spi2", "sclk_spi2_peric", ENABLE_SCLK_PERIC,
>                         5, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_SPI1, "sclk_spi1", "sclk_spi1_peric", ENABLE_SCLK_PERIC,
> -                       4, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
> +                       4, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_SPI0, "sclk_spi0", "sclk_spi0_peric", ENABLE_SCLK_PERIC,
>                         3, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_UART2, "sclk_uart2", "sclk_uart2_peric",
> -- 
> 2.8.1
> 
