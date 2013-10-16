From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Oct 2013 16:14:52 +0200
Subject: [PATCH] pinctrl: at91: correct a few typos
In-Reply-To: <1381932753-32081-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1381932753-32081-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <525E9F5C.9050609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2013 16:12, Alexandre Belloni :
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
>   drivers/pinctrl/pinctrl-at91.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index f350fd2..ad48179 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -243,7 +243,7 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
>   	int i;
>
>   	/*
> -	 * first find the group of this node and check if we need create
> +	 * first find the group of this node and check if we need to create
>   	 * config maps for pins
>   	 */
>   	grp = at91_pinctrl_find_group_by_name(info, np->name);
> @@ -564,7 +564,7 @@ static int at91_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
>   		info->functions[selector].name, info->groups[group].name);
>
>   	/* first check that all the pins of the group are valid with a valid
> -	 * paramter */
> +	 * parameter */
>   	for (i = 0; i < npins; i++) {
>   		pin = &pins_conf[i];
>   		ret = pin_check_config(info, info->groups[group].name, i, pin);
> @@ -958,7 +958,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
>   	at91_pinctrl_child_count(info, np);
>
>   	if (info->nbanks < 1) {
> -		dev_err(&pdev->dev, "you need to specify atleast one gpio-controller\n");
> +		dev_err(&pdev->dev, "you need to specify at least one gpio-controller\n");
>   		return -EINVAL;
>   	}
>
> @@ -1495,7 +1495,7 @@ static int at91_gpio_of_irq_setup(struct device_node *node,
>   	if (at91_gpio->pioc_idx)
>   		prev = gpio_chips[at91_gpio->pioc_idx - 1];
>
> -	/* The toplevel handler handles one bank of GPIOs, except
> +	/* The top level handler handles one bank of GPIOs, except
>   	 * on some SoC it can handles up to three...
>   	 * We only set up the handler for the first of the list.
>   	 */
>


-- 
Nicolas Ferre
