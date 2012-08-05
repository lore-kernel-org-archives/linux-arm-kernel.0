From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 5 Aug 2012 10:56:22 +0800
Subject: [PATCH v3 4/9] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <CACRpkdaJhzzckg12uZrgweoOgC44VNb=0AEdp96AV2O0UM+AnA@mail.gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <1343470061-16879-5-git-send-email-zonque@gmail.com>
 <CACRpkdaJhzzckg12uZrgweoOgC44VNb=0AEdp96AV2O0UM+AnA@mail.gmail.com>
Message-ID: <CAN1soZzOTMChr7WQzguH_CPQ8s=tyrsjwmAYNSBAVeMtwRE2uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 8:12 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Jul 28, 2012 at 12:07 PM, Daniel Mack <zonque@gmail.com> wrote:
>
>> Simplify the code in gpio-pxa.c and make them based on irq_base.
>> When not probed from devicetree, initialize irq_base from
>> PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
>> still works.
>>
>> +#ifdef CONFIG_ARCH_PXA
>> +               if (gpio_is_pxa_type(gpio_type))
>> +                       irq_base = PXA_GPIO_TO_IRQ(0);
>> +#endif
>> +#ifdef CONFIG_ARCH_MMP
>> +               if (gpio_is_mmp_type(gpio_type))
>> +                       irq_base = MMP_GPIO_TO_IRQ(0);
>> +#endif
>
> Grrr. Can we think of a way to get rid of these #ifdef:s?
>

It's used for non-DT mode. This driver is used in both arch-pxa
and arch-mmp. Since we use static irq allocation in non-DT mode,
we have to use this kind of code to get irq_base.

What Daniel did is only simplifying the code.

Regards
Haojian
