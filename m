From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 23:02:26 +0800
Subject: [PATCH v7 05/15] gpio: fix wrong checking condition for gpio range
In-Reply-To: <50F93DA0.1060708@mvista.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-6-git-send-email-haojian.zhuang@linaro.org>
 <50F93DA0.1060708@mvista.com>
Message-ID: <CAD6h2NQOY5DPS-y3rpTFrEu3LNTnPFgX2ivfNYqcoqoRGZH5mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 January 2013 20:18, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 18-01-2013 11:31, Haojian Zhuang wrote:
>
>> Since index++ calculates from 0, the checking condition of "while
>> (index++)" is always fake. So replace it by unconditional loop.
>
>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>   drivers/gpio/gpiolib-of.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>
>
>> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
>> index b1f0682..011e1e98 100644
>> --- a/drivers/gpio/gpiolib-of.c
>> +++ b/drivers/gpio/gpiolib-of.c
>> @@ -228,7 +228,7 @@ static void of_gpiochip_add_pin_range(struct gpio_chip
>> *chip)
>>         if (!np)
>>                 return;
>>
>> -       do {
>> +       for (;;) {
>
>
>    Why not:
>
>         for (;; index++) {
>
OK. I'll update it.

>
>>                 ret = of_parse_phandle_with_args(np, "gpio-ranges",
>>                                 "#gpio-range-cells", index, &pinspec);
>>                 if (ret)
>> @@ -254,8 +254,8 @@ static void of_gpiochip_add_pin_range(struct gpio_chip
>> *chip)
>>
>>                 if (ret)
>>                         break;
>> -
>> -       } while (index++);
>> +               index++;
>> +       }
>>   }
>
>
> WBR, Sergei
>
