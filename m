From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Jan 2015 14:31:25 +0100
Subject: [PATCH] pinctrl: hide PCONFDUMP in #ifdef
In-Reply-To: <4217929.mzU2TuSLSj@wuerfel>
References: <4217929.mzU2TuSLSj@wuerfel>
Message-ID: <CACRpkdZD-LHQaNOH_b+WWvo8RrbVKj5DB7q_m-aNq=W-sEfvtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 5:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The zynq and qcom-spmi pinctrl drivers both use pin_config_item arrays
> to provide extra interfaces in debugfs. This structure and the
> PCONFDUMP macro are not defined if CONFIG_DEBUG_FS is turned off,
> so we get build errors like:
>
> pinctrl/qcom/pinctrl-spmi-gpio.c:139:37: error: array type has incomplete element type
>  static const struct pin_config_item pmic_conf_items[ARRAY_SIZE(pmic_gpio_bindings)] = {
>                                      ^
> pinctrl/qcom/pinctrl-spmi-gpio.c:140:2: error: implicit declaration of function 'PCONFDUMP' [-Werror=implicit-function-declaration]
>   PCONFDUMP(PMIC_GPIO_CONF_PULL_UP,  "pull up strength", NULL, true),
>   ^
> pinctrl/qcom/pinctrl-spmi-gpio.c:139:37: warning: 'pmic_conf_items' defined but not used [-Wunused-variable]
>  static const struct pin_config_item pmic_conf_items[ARRAY_SIZE(pmic_gpio_bindings)] = {
>
> Lacking any better idea to solve this nicely, this patch uses #ifdef
> to hide the structures, just like the pinctrl core does.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
