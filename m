From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 12:53:00 +0100
Subject: [PATCH 1/1] clk: exynos-5420: Fix VPLL lock offset
In-Reply-To: <1394681222-27882-1-git-send-email-sachin.kamat@linaro.org>
References: <1394681222-27882-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <53219C1C.1030501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On 13.03.2014 04:27, Sachin Kamat wrote:
> Set it as per the user manual.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/clk/samsung/clk-exynos5420.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 60b26819bed5..7fd6bea467fd 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -33,7 +33,7 @@
>   #define RPLL_LOCK		0x10050
>   #define IPLL_LOCK		0x10060
>   #define SPLL_LOCK		0x10070
> -#define VPLL_LOCK		0x10070
> +#define VPLL_LOCK		0x10080
>   #define MPLL_LOCK		0x10090
>   #define CPLL_CON0		0x10120
>   #define DPLL_CON0		0x10128
>

Looks fine. Will queue for 3.15, since ATM there is no support for PLL 
rate setting on Exynos 5420 (no rate tables registered).

Best regards,
Tomasz
