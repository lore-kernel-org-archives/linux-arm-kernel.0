From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Feb 2013 15:40:51 -0800
Subject: [PATCH v8 09/12] pinctrl: generic: add auto pull config parameter
In-Reply-To: <1360602659-4774-10-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130213234051.GT7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130211 09:15]:
> There's only one bit to control pin bias as enabled or disabled for some
> pins in OMAP SoC. So append PIN_CONFIG_BIAS_AUTO_PULL for this case.
> User shouldn't switch pin state between AUTO_PULL and PULL_UP/PULL_DOWN,
> since they're similiar concepts.

Please just drop patch from the series for now. This needs further research
on what the hardware is actually doing. I suspect we can replace this with
just either PIN_CONFIG_BIAS_PULL_UP or PIN_CONFIG_BIAS_PULL_DOWN.

Regards,

Tony
 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/pinctrl/pinconf-generic.c       |    1 +
>  include/linux/pinctrl/pinconf-generic.h |    3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
> index ef24230..4a67848 100644
> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
> @@ -37,6 +37,7 @@ struct pin_config_item {
>  struct pin_config_item conf_items[] = {
>  	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL),
>  	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL),
> +	PCONFDUMP(PIN_CONFIG_BIAS_AUTO_PULL, "input bias auto pull", NULL),
>  	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", NULL),
>  	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", NULL),
>  	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL),
> diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
> index 3e7909a..f2daff4 100644
> --- a/include/linux/pinctrl/pinconf-generic.h
> +++ b/include/linux/pinctrl/pinconf-generic.h
> @@ -29,6 +29,8 @@
>   *	if for example some other pin is going to drive the signal connected
>   *	to it for a while. Pins used for input are usually always high
>   *	impedance.
> + * @PIN_CONFIG_BIAS_AUTO_PULL: the pin will be pulled without specifying
> + *      pull-up or pull-down.
>   * @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
>   *	impedance to VDD). If the argument is != 0 pull-up is enabled,
>   *	if it is 0, pull-up is disabled.
> @@ -76,6 +78,7 @@
>  enum pin_config_param {
>  	PIN_CONFIG_BIAS_DISABLE,
>  	PIN_CONFIG_BIAS_HIGH_IMPEDANCE,
> +	PIN_CONFIG_BIAS_AUTO_PULL,
>  	PIN_CONFIG_BIAS_PULL_UP,
>  	PIN_CONFIG_BIAS_PULL_DOWN,
>  	PIN_CONFIG_DRIVE_PUSH_PULL,
> -- 
> 1.7.10.4
> 
