From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 15 Jun 2016 11:27:47 -0400
Subject: [PATCH 4/5] clk: max77686: Add support for MAX77620 clocks
In-Reply-To: <1466000018-16784-5-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-5-git-send-email-ldewangan@nvidia.com>
Message-ID: <ba35a3a4-91f9-a9d8-16c9-0cdd409da48d@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 06/15/2016 10:13 AM, Laxman Dewangan wrote:
> Maxim Max77620 has one 32KHz clock output and the clock HW
> IP used on this PMIC is same as what it is there in the MAX77686.
> 
> Add clock driver support for MAX77620 on the MAX77686 driver.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  drivers/clk/Kconfig        |  7 ++++---
>  drivers/clk/clk-max77686.c | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
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

s/MAX77620/77620

Besides this minor nit, the patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
