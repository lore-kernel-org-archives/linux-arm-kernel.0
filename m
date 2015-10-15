From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 15 Oct 2015 21:42:50 +0200
Subject: [PATCH 5/7] ARM: mach-stm32: Select pinctrl
In-Reply-To: <1444853247-31114-6-git-send-email-mcoquelin.stm32@gmail.com>
References: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1444853247-31114-6-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <562001BA.5040108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Commenting myself before someone else does...

On 10/14/2015 10:07 PM, Maxime Coquelin wrote:
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>   arch/arm/Kconfig                          | 1 +
>   drivers/pinctrl/stm32/pinctrl-stm32f429.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index bf94e54..8b1afd4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -985,6 +985,7 @@ config ARCH_STM32
>   	select ARMV7M_SYSTICK
>   	select CLKSRC_STM32
>   	select RESET_CONTROLLER
> +	select PINCTRL
This is not in alphabetical order...

>   	help
>   	  Support for STMicroelectronics STM32 processors.
>
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f429.c b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
> index 3535037..f34016b 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32f429.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
> @@ -1564,7 +1564,7 @@ static const struct stm32_desc_pin stm32f429_pins[] = {
>   	),
>   };
>
> -struct stm32_pinctrl_match_data stm32f429_match_data = {
> +static struct stm32_pinctrl_match_data stm32f429_match_data = {
>   	.pins = stm32f429_pins,
>   	.npins = ARRAY_SIZE(stm32f429_pins),
>   };
>

And I didn't fixed-up in the good patch... Should go in the driver one.

Will be fixed in the v2.

Maxime
