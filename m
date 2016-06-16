From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jun 2016 10:07:52 -0400
Subject: [PATCH V2 4/4] clk: max77686: Add support for MAX77620 clocks
In-Reply-To: <1466083407-28793-5-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
 <1466083407-28793-5-git-send-email-ldewangan@nvidia.com>
Message-ID: <77dde1c3-c4da-faa6-ecd4-ba318abf5ed4@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 06/16/2016 09:23 AM, Laxman Dewangan wrote:
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

I already gave you my Reviewed-by for v1 but it seems you missed:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
 
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
> +	depends on MFD_MAX77686 || MFD_MAX77620
>  	---help---
> -	  This driver supports Maxim 77686/77802 crystal oscillator clock.
> +	  This driver supports Maxim 77686/77802/MAX77620 crystal oscillator

And it seems you also missed the minor nit I mentioned in v1 about using
77620 instead of MAX77620 here for naming consistency with the other IP.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
