From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 09 Sep 2014 12:27:22 +0100
Subject: [PATCH v2] pinctrl: st: remove gpiochip in failure cases
In-Reply-To: <1410249101-12234-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1410249101-12234-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <540EE41A.2070807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


On 09/09/14 08:51, Pramod Gurav wrote:
> This patch releases gpiochip related resources by calling
> gpiochip_remove when gpiochip_irqchip_add fails.
>
> CC: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.com>
> CC: Maxime Coquelin <maxime.coquelin@st.com>
> CC: Patrice Chotard <patrice.chotard@st.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
> Changes since v1:
> Dropped adding remove function as it will never be tested as
> the driver is bool.
>
>   drivers/pinctrl/pinctrl-st.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 5475374..af2f589 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1517,6 +1517,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
>   					   0, handle_simple_irq,
>   					   IRQ_TYPE_LEVEL_LOW);
>   		if (err) {
> +			gpiochip_remove(&bank->gpio_chip);
>   			dev_info(dev, "could not add irqchip\n");
>   			return err;
>   		}
>
