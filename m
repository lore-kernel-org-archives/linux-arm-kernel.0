From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 3 Jun 2018 11:37:53 +0300
Subject: [PATCH 3/3] pinctrl: actions: Add interrupt support for OWL S900
 SoC
In-Reply-To: <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
 <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHp75Ve8ZCbEqnYK0KqtCHQm-EOUWRSyMzi51P+3_7brtXq6dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 2, 2018 at 7:54 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add interrupt support for Actions Semi OWL S900 SoC.

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;

At which circumstances the above possible?

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;

Ditto.

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;

Ditto.

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return -ENODEV;

Ditto.


> +       for (i = 0; i < chip->ngpio; i++) {
> +               irqno = irq_create_mapping(pctrl->domain, i);
> +               irq_set_chip_and_handler(irqno, &owl_gpio_irq_chip,
> +                                        handle_edge_irq);
> +               irq_set_chip_data(irqno, pctrl);
> +       }

I'm not sure the handle_edge_irq() is a correct handler here. It would
be handle_bad_irq() until IRQ has been requested properly.
No?

> +/* GPIO TYPE Bit Definition */
> +#define OWL_GPIO_INT_LEVEL_HIGH                0
> +#define OWL_GPIO_INT_LEVEL_LOW         1
> +#define OWL_GPIO_INT_EDGE_RISING       2
> +#define OWL_GPIO_INT_EDGE_FALLING      3

> +#define OWL_GPIO_INT_MASK              3

GENMASK?

-- 
With Best Regards,
Andy Shevchenko
