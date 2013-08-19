From: markus.mayer@linaro.org (Markus Mayer)
Date: Mon, 19 Aug 2013 11:41:51 -0700
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <CACRpkdbjtO_chMhrywXDbqztmuQv4abJpg-QVfuVZh9JGGdLaQ@mail.gmail.com>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
 <CACRpkdbjtO_chMhrywXDbqztmuQv4abJpg-QVfuVZh9JGGdLaQ@mail.gmail.com>
Message-ID: <CAPdLdqmCyXrZFbNVju+RWYu4MS+uoK9Ju5yb6RAR+xDQvKsRoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 August 2013 05:51, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jul 26, 2013 at 10:25 PM, Markus Mayer <markus.mayer@linaro.org> wrote:
>
>> --- a/arch/arm/boot/dts/bcm11351.dtsi
>> +++ b/arch/arm/boot/dts/bcm11351.dtsi
>> @@ -63,6 +63,22 @@
>>                 clock-frequency = <32768>;
>>         };
>>
>> +       gpio: gpio at 35003000 {
>> +               compatible = "brcm,kona-gpio";
>> +               reg = <0x35003000 0x800>;
>> +               interrupts =
>> +                      <0x0 106 0x4
>> +                       0x0 115 0x4
>> +                       0x0 114 0x4
>> +                       0x0 113 0x4
>> +                       0x0 112 0x4
>> +                       0x0 111 0x4>;
>> +               #gpio-cells = <2>;
>> +               #interrupt-cells = <2>;
>> +               gpio-controller;
>> +               interrupt-controller;
>> +       };
>
> Do this:
>
> #include <dt-bindings//interrupt-controller/irq.h>
> #include <dt-bindings/interrupt-controller/arm-gic.h>
>
> Rewrite like this:
>
> +               interrupts =
> +                      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
> +                       GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
>
> As you can see we can now understand the dts file.
>
> Possibly this should also be done in the examples.

Thanks for the feedback. This change will be part of the next revision
that I am about to send out (in dtsi & examples).

Regards,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
