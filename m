From: syin@broadcom.com (Sherman Yin)
Date: Fri, 17 Jan 2014 11:51:30 -0800
Subject: [PATCH] pinctrl: capri: add dependency on OF
In-Reply-To: <1389912312-16285-1-git-send-email-linus.walleij@linaro.org>
References: <1389912312-16285-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <52D989C2.6030603@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-01-16 02:45 PM, Linus Walleij wrote:
> As this driver is using pinconf_generic_dt_node_to_map_pin() it
> needs to depend on OF so as not to cause build problems on
> archs that do not support OF.
>
> Cc: Sherman Yin <syin@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/pinctrl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index f1dda4d9de13..be361b7cd30f 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -106,6 +106,7 @@ config PINCTRL_BCM2835
>
>   config PINCTRL_CAPRI
>   	bool "Broadcom Capri pinctrl driver"
> +	depends on OF
>   	select PINMUX
>   	select PINCONF
>   	select GENERIC_PINCONF
>

Thanks for the fix, Linus.  While we're visiting this config, should we 
add "depends on MACH_BCM_MOBILE" as well?

Thanks,
Sherman
