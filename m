From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 29 Aug 2018 15:49:07 +0200
Subject: [PATCH] ARM: configs: add generic resistive touchscreen
In-Reply-To: <1535525577-21148-1-git-send-email-eugen.hristev@microchip.com>
References: <1535525577-21148-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180829134907.GF16561@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Eugen,

On 29/08/2018 09:52:57+0300, Eugen Hristev wrote:
> Add generic resistive touchscreen CONFIG_TOUCHSCREEN_ADC to defconfigs
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  arch/arm/configs/sama5_defconfig    | 1 +

I would make two separate patches because multi_v7 has a high chance of
conflicting while sama5_defconfig will not.

>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index fc33444..a1b2cfa 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -282,6 +282,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
>  CONFIG_MOUSE_CYAPA=m
>  CONFIG_MOUSE_ELAN_I2C=y
>  CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_TOUCHSCREEN_ADC=m
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=m
>  CONFIG_TOUCHSCREEN_MMS114=m
>  CONFIG_TOUCHSCREEN_WM97XX=m
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 2080025..ead6826 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -116,6 +116,7 @@ CONFIG_KEYBOARD_QT1070=y
>  CONFIG_KEYBOARD_GPIO=y
>  # CONFIG_INPUT_MOUSE is not set
>  CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_TOUCHSCREEN_ADC=y
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=y
>  # CONFIG_SERIO is not set
>  CONFIG_LEGACY_PTY_COUNT=4
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
