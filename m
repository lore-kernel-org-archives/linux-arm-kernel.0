From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 21 Feb 2018 23:38:33 +0100
Subject: [PATCH v2 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <CAHp75VfLkmZp7HwX-du4EYdtJ8h=y59OrSbu53Ltf-_kFfpczg@mail.gmail.com>
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
 <20180221160044.15089-9-manivannan.sadhasivam@linaro.org>
 <CAHp75VfLkmZp7HwX-du4EYdtJ8h=y59OrSbu53Ltf-_kFfpczg@mail.gmail.com>
Message-ID: <aa4ce18d-fd83-c7f1-22fc-59538881ea51@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.02.2018 um 20:13 schrieb Andy Shevchenko:
> On Wed, Feb 21, 2018 at 6:00 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
>> controlling the gpio shares the same register range with pinctrl block.
>>
>> GPIO registers are organized as 6 banks and each bank controls the
>> maximum of 32 gpios.
> 
>> +static void owl_gpio_set_reg(void __iomem *base, unsigned int pin, int flag)
>> +{
>> +       u32 val;
>> +
>> +       if (flag) {
>> +               val = readl(base);
>> +               val |= BIT(pin);
>> +               writel(val, base);
>> +       } else {
>> +               val = readl(base);
>> +               val &= ~BIT(pin);
>> +               writel(val, base);
>> +       }
>> +}
> 
> Why not to use the same pattern as below?
> 
> readl()
> if ()
>  ...
> else
> ...
> writel()
> 
> ?

And shouldn't that be readl_relaxed() and writel_relaxed()?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
