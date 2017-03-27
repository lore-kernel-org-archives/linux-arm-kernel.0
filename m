From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 27 Mar 2017 12:23:49 +0200
Subject: [PATCH 2/8] pinctrl: stm32: use gpio-ranges to declare bank range
In-Reply-To: <CACRpkdbhqT688-1MajRshqgn0bH0h2s=LM06gEQYgRmMZC_n0g@mail.gmail.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
 <1485533721-9019-3-git-send-email-alexandre.torgue@st.com>
 <CACRpkdYtZCJVrZhXOPXd-MNMX0Ry_H1dLQopKwsj9HnO03BtKg@mail.gmail.com>
 <2d0cd144-9a72-52d5-b2c9-c6c9e09ac494@st.com>
 <CACRpkdbhqT688-1MajRshqgn0bH0h2s=LM06gEQYgRmMZC_n0g@mail.gmail.com>
Message-ID: <7be9d251-f177-ce15-9d91-d8533ddffa06@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On 02/01/2017 04:01 PM, Linus Walleij wrote:
> On Mon, Jan 30, 2017 at 5:29 PM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> On 01/30/2017 04:19 PM, Linus Walleij wrote:
>
>>>> +       if (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
>>>> &args))
>>>> +               bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
>>>> +       else {
>>>> +               range->name = bank->gpio_chip.label;
>>>> +               range->id = bank_nr;
>>>> +               range->pin_base = range->id * STM32_GPIO_PINS_PER_BANK;
>>>> +               range->base = range->id * STM32_GPIO_PINS_PER_BANK;
>>>> +               range->npins = npins;
>>>> +               range->gc = &bank->gpio_chip;
>>>> +               pinctrl_add_gpio_range(pctl->pctl_dev,
>>>> +                                      &pctl->banks[bank_nr].range);
>>>> +       }
>>
>>
>> I Keep the old way to get range in order to keep compatibility with older
>> device tree (if no gpio ranges are defined).
>
> Aha I understand. Sorry for my stupidity.
>
> Go ahead with this!

I saw an issue about this patch. It doesn't seem to be merged, so I will 
send a V2 only for this patch.

Regards
Alex


>
> Yours,
> Linus Walleij
>
