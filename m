From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Jun 2016 08:03:29 +0200
Subject: [PATCH V2 4/4] clk: max77686: Add support for MAX77620 clocks
In-Reply-To: <1466083407-28793-5-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
 <1466083407-28793-5-git-send-email-ldewangan@nvidia.com>
Message-ID: <576392B1.9040801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 03:23 PM, Laxman Dewangan wrote:
> Maxim Max77620 has one 32KHz clock output and the clock HW
> IP used on this PMIC is same as what it is there in the MAX77686.
> 
> Add clock driver support for MAX77620 on the MAX77686 driver.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> Changes from V1:
> - Updated based on changes done in first patch.
> ---
>  drivers/clk/Kconfig        |  7 ++++---
>  drivers/clk/clk-max77686.c | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 6afad74..d75f4c5 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -32,10 +32,11 @@ config COMMON_CLK_WM831X
>  source "drivers/clk/versatile/Kconfig"
>  
>  config COMMON_CLK_MAX77686
> -	tristate "Clock driver for Maxim 77686/77802 MFD"
> -	depends on MFD_MAX77686
> +	tristate "Clock driver for Maxim 77686/77802/MAX77620 MFD"

You missed Javier's comment here. Just
"Maxim 77686/77802/77620"

> +	depends on MFD_MAX77686 || MFD_MAX77620
>  	---help---
> -	  This driver supports Maxim 77686/77802 crystal oscillator clock.
> +	  This driver supports Maxim 77686/77802/MAX77620 crystal oscillator

Ditto

Beside that:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
