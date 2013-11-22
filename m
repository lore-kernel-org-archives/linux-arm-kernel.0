From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Nov 2013 09:16:39 +0000
Subject: [PATCH v3 4/5] regulator: max14577: Add regulator driver for
 Maxim 14577
In-Reply-To: <1385109972-28059-5-git-send-email-k.kozlowski@samsung.com>
References: <1385109972-28059-1-git-send-email-k.kozlowski@samsung.com>
 <1385109972-28059-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131122091639.GG23067@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Nov 2013, Krzysztof Kozlowski wrote:

> MAX14577 chip is a multi-function device which includes MUIC,
> charger and voltage regulator. The driver is located in drivers/mfd.
> 
> This patch adds regulator driver for MAX14577 chip. There are two
> regulators in this chip:
> 1. Safeout LDO with constant voltage output of 4.9V. It can be only
>    enabled or disabled.
> 2. Current regulator for the charger. It provides current from 90mA up
>    to 950mA.
> Driver supports Device Tree.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/regulator/Kconfig    |    7 ++
>  drivers/regulator/Makefile   |    1 +
>  drivers/regulator/max14577.c |  272 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max14577.h |    1 -
>  4 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/regulator/max14577.c

<snip>

> --- a/include/linux/mfd/max14577.h
> +++ b/include/linux/mfd/max14577.h
> @@ -63,7 +63,6 @@ struct max14577_platform_data {
>  
>  	int (*set_gpio_pogo_cb) (int new_dev);
>  
> -	int num_regulators;

This doesn't belong in this patch.

>  	struct max14577_regulator_platform_data *regulators;
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
