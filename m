From: k.kozlowski.k.linux@gmail.com (Krzysztof Kozlowski)
Date: Tue, 09 Sep 2014 14:14:43 +0200
Subject: [PATCH] clk: samsung: exynos3250: fix width and shift of
 div_spi0_isp clock
In-Reply-To: <1410263697-768-1-git-send-email-pankaj.dubey@samsung.com>
References: <1410263697-768-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <540EEF33.9010207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.09.2014 13:54, Pankaj Dubey wrote:
> Update shift and width field of div_spi0_isp clock as per Exynos3250
> user manual.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos3250.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>
> diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
> index ba8f073f..a3dee34 100644
> --- a/drivers/clk/samsung/clk-exynos3250.c
> +++ b/drivers/clk/samsung/clk-exynos3250.c
> @@ -406,7 +406,7 @@ static struct samsung_div_clock div_clks[] __initdata = {
>   	DIV(CLK_DIV_SPI1_ISP, "div_spi1_isp", "mout_spi1_isp", DIV_ISP, 16, 4),
>   	DIV_F(CLK_DIV_SPI0_ISP_PRE, "div_spi0_isp_pre", "div_spi0_isp",
>   		DIV_ISP, 8, 8, CLK_SET_RATE_PARENT, 0),
> -	DIV(CLK_DIV_SPI0_ISP, "div_spi0_isp", "mout_spi0_isp", DIV_ISP, 0, 4),
> +	DIV(CLK_DIV_SPI0_ISP, "div_spi0_isp", "mout_spi0_isp", DIV_ISP, 4, 4),
>
>   	/* DIV_FSYS0 */
>   	DIV_F(CLK_DIV_TSADC_PRE, "div_tsadc_pre", "div_tsadc", DIV_FSYS0, 8, 8,
>
