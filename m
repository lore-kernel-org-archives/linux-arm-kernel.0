From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 8 Aug 2017 10:06:45 +0900
Subject: [PATCH] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <CACRpkdZ26q09s-L2wVy+Vv5rV0Enjith0AJ_sJCAH3kvzvjn1Q@mail.gmail.com>
References: <1501758371-25316-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdZWxjwDnVy5f2rLAWs=+T=5SnwyU8dz1FW1eg8dk8JN_Q@mail.gmail.com>
 <CAK7LNAT4FvsX2-hYrKYmrftEZZb_RZOrfZoKWvR8hopt9jT8-Q@mail.gmail.com>
 <CACRpkdZ26q09s-L2wVy+Vv5rV0Enjith0AJ_sJCAH3kvzvjn1Q@mail.gmail.com>
Message-ID: <CAK7LNATCZ9r6KCbFLAW68r9WtYrQ2OvWOZd0AXW4GbdHjHQDVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2017-08-08 0:37 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Aug 7, 2017 at 3:50 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> Adding "interrupts" property in DT causes
>> of_pupulate_default_populate() to assign virtual IRQ numbers
>> before driver probing.  So it does not work well with IRQ domain hierarchy.
>
> I think I heard some noise about this the week before.
>
>> For pinctrl/stm32/pinctrl-stm32.c,
>> I do not see "interrupts", so it just straight maps the irq numbers.
>
> I think OMAP and DaVinci does someting similar too. This is from a recent
> DaVinci patch from Keerthy:
>
> +Example for 66AK2G:
> +
> +gpio0: gpio at 2603000 {
> +       compatible = "ti,k2g-gpio", "ti,keystone-gpio";
> +       reg = <0x02603000 0x100>;
> +       gpio-controller;
> +       #gpio-cells = <2>;
> +       interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 440 IRQ_TYPE_EDGE_RISING>;
> +       interrupt-controller;
> +       #interrupt-cells = <2>;
> +       ti,ngpio = <144>;
> +       ti,davinci-gpio-unbanked = <0>;
> +       clocks = <&k2g_clks 0x001b 0x0>;
> +       clock-names = "gpio";
> +};
>
>
> That looks fairly similar.
>

I do not think so.


I do not see .alloc hook in drivers/gpio/gpio-davinci.c
so this driver is unrelated to IRQ domain hierarchy.






-- 
Best Regards
Masahiro Yamada
