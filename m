From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 16:01:26 +0100
Subject: [PATCH 2/8] pinctrl: stm32: use gpio-ranges to declare bank range
In-Reply-To: <2d0cd144-9a72-52d5-b2c9-c6c9e09ac494@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
 <1485533721-9019-3-git-send-email-alexandre.torgue@st.com>
 <CACRpkdYtZCJVrZhXOPXd-MNMX0Ry_H1dLQopKwsj9HnO03BtKg@mail.gmail.com>
 <2d0cd144-9a72-52d5-b2c9-c6c9e09ac494@st.com>
Message-ID: <CACRpkdbhqT688-1MajRshqgn0bH0h2s=LM06gEQYgRmMZC_n0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 5:29 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 01/30/2017 04:19 PM, Linus Walleij wrote:

>>> +       if (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
>>> &args))
>>> +               bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
>>> +       else {
>>> +               range->name = bank->gpio_chip.label;
>>> +               range->id = bank_nr;
>>> +               range->pin_base = range->id * STM32_GPIO_PINS_PER_BANK;
>>> +               range->base = range->id * STM32_GPIO_PINS_PER_BANK;
>>> +               range->npins = npins;
>>> +               range->gc = &bank->gpio_chip;
>>> +               pinctrl_add_gpio_range(pctl->pctl_dev,
>>> +                                      &pctl->banks[bank_nr].range);
>>> +       }
>
>
> I Keep the old way to get range in order to keep compatibility with older
> device tree (if no gpio ranges are defined).

Aha I understand. Sorry for my stupidity.

Go ahead with this!

Yours,
Linus Walleij
