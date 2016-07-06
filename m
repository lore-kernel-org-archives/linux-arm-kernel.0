From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Jul 2016 14:43:12 +0200
Subject: [PATCH v2] pinctrl: Add STM32F746 MCU support
In-Reply-To: <1467798418-12124-2-git-send-email-alexandre.torgue@st.com>
References: <1467798418-12124-1-git-send-email-alexandre.torgue@st.com>
 <1467798418-12124-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdaQ+SY5x_wjZUK4d4UHmrfnTrKghTJ96WEWqkzhphq-ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2016 at 11:46 AM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> This patch which adds STM32F746 pinctrl and GPIO support, relies on the
> generic STM32 pinctrl driver.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

(...)
> +static struct platform_driver stm32f746_pinctrl_driver = {
> +       .probe = stm32_pctl_probe,
> +       .driver = {
> +               .name = "stm32f746-pinctrl",
> +               .of_match_table = stm32f746_pctrl_match,
> +       },
> +};
> +
> +static int __init stm32f746_pinctrl_init(void)
> +{
> +       return platform_driver_register(&stm32f746_pinctrl_driver);
> +}
> +device_initcall(stm32f746_pinctrl_init);

Please use builtin_platform_driver() for this.

Yours,
Linus Walleij
