From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 24 Aug 2011 14:24:32 +0800
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4yCAcu3uiSuDQ13ai8tmnoDkniQymp6M7DGJi84AW4mBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +int foo_list(struct pinmux_dev *pmxdev, unsigned selector)

pinctrl_dev?

> +{
> + ? ? ? if (selector >= ARRAY_SIZE(myfuncs))
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? return 0;
> +}
> +
> +const char *foo_get_fname(struct pinmux_dev *pmxdev, unsigned selector)

pinctrl_dev?

> +{
> + ? ? ? if (selector >= ARRAY_SIZE(myfuncs))
> + ? ? ? ? ? ? ? return NULL;
> + ? ? ? return myfuncs[selector].name;
> +}
> +
> +static int foo_get_pins(struct pinmux_dev *pmxdev, unsigned selector,
> + ? ? ? ? ? ? ? ? ? ? ? unsigned ** const pins, unsigned * const num_pins)

pinctrl_dev?

> +{
> + ? ? ? if (selector >= ARRAY_SIZE(myfuncs))
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? *pins = myfuncs[selector].pins;
> + ? ? ? *num_pins = myfuncs[selector].num_pins;
> + ? ? ? return 0;
> +}
> +
> +int foo_enable(struct pinmux_dev *pmxdev, unsigned selector)
> +{
> + ? ? ? if (selector < ARRAY_SIZE(myfuncs))
> + ? ? ? ? ? ? ? write((read(MUX)|(1<<selector)), MUX)
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> + ? ? ? return -EINVAL;
> +}
> +
> +int foo_disable(struct pinmux_dev *pmxdev, unsigned selector)

pinctrl_dev?

-barry
