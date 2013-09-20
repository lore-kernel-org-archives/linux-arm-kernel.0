From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 21:28:02 +0200
Subject: [PATCH 5/7] staging: media/lirc: switch to use gpiolib
In-Reply-To: <m3d2ocvrx7.fsf@intrepid.localdomain>
References: <1378816283-8164-1-git-send-email-linus.walleij@linaro.org>
 <m3d2ocvrx7.fsf@intrepid.localdomain>
Message-ID: <CACRpkda5x78wMVm=vOB4_Bb8hsa6Sumfv0CANPBtOdHq1LxDYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 2:15 PM, Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> +++ b/drivers/staging/media/lirc/lirc_serial.c
>> @@ -839,6 +839,16 @@ static int lirc_serial_probe(struct platform_device *dev)
>>  {
>>       int i, nlow, nhigh, result;
>>
>> +#ifdef CONFIG_LIRC_SERIAL_NSLU2
>> +     /* This GPIO is used for a LED on the NSLU2 */
>> +     result = devm_gpio_request(dev, NSLU2_LED_GRN, "lirc-serial");
>
> Will this succeed with the LED driver already loaded? Should the user
> unload it first?

Hm if this driver should use this as a LED it needs to register
a trigger for that GPIO LED instead. A GPIO can not be used by
two consumers at the same time...

Yours,
Linus Walleij
