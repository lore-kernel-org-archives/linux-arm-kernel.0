From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 12:00:56 +0000
Subject: Qualcomm PMIC8XXX keypad never worked?
In-Reply-To: <5887114.1jrNo21sGX@wuerfel>
References: <5887114.1jrNo21sGX@wuerfel>
Message-ID: <20140311120056.GH21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Something in the MFD_PM8XXX driver must have changed recently that now allows
> the KEYBOARD_PMIC8XXX driver to be enabled. Unfortunately, it does not build
> because of a dependency on the <linux/mfd/pm8xxx/gpio.h> header file that
> does not exist.

I have it?

-rw-r--r-- 1 lee lee 2147 Dec 18 11:52 include/linux/mfd/pm8xxx/core.h

> In order to keep 'make randconfig' working on my test box, I have disabled
> this driver, but it would be nice of someone could have a look into fixing it.

Can you send me the config that breaks please?

> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -470,7 +470,7 @@ config KEYBOARD_PXA930_ROTARY
>  
>  config KEYBOARD_PMIC8XXX
>         tristate "Qualcomm PMIC8XXX keypad support"
> -       depends on MFD_PM8XXX
> +       depends on MFD_PM8XXX && BROKEN
>         select INPUT_MATRIXKMAP
>         help
>           Say Y here if you want to enable the driver for the PMIC8XXX
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
