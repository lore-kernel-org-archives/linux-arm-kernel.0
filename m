From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Feb 2014 11:37:56 +0100
Subject: [PATCH 5/8] tty/serial: at91: add dtr control via gpio
In-Reply-To: <CACQ1gAjQi+g0=HcR9K0rBQxBUZ_cN783sCWx40P5Hec-BdRtVg@mail.gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
 <1391785155-18525-6-git-send-email-richard.genoud@gmail.com>
 <1391786494.259974704@f81.i.mail.ru>
 <CACQ1gAjQi+g0=HcR9K0rBQxBUZ_cN783sCWx40P5Hec-BdRtVg@mail.gmail.com>
Message-ID: <52F8AC04.50103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2014 11:24, Richard Genoud :
> 2014-02-07 16:21 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
>> Hello.
>>
>> ???????,  7 ??????? 2014, 15:59 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
>>> On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
>>> so we have to control them via GPIO.
>>>
>>> This patch permits to use a GPIO to control the DTR signal.
>>>
>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>> ---
>> ...
>>> +     if (gpio_is_valid(atmel_port->gpio.dtr)) {
>>> +             if (mctrl & TIOCM_DTR)
>>> +                     gpio_set_value(atmel_port->gpio.dtr, 0);
>>> +             else
>>> +                     gpio_set_value(atmel_port->gpio.dtr, 1);
>>> +     }
>>
>> So, if you use GPIO for such purpose (here and in the other patches),
>> you should take and use GPIO active level from bindings.
>> It will make use of GPIO more flexible and deliver us from further special
>> possible bindings to declare the active level.
> Yes, I could do that. I'll have to change the alreday merged RTS
> binding so that it gets it's active level from DTS, but I don't think
> it's a problem, since it's not already in mainline.
> Linus, Nicolas, what do you think ?

Yes I agree. It is not used yet, so the sooner we move to this
specification, the better.

>> Actually, it would be good to have a separate unit for mctrl GPIOs,
>> which could be used for other drivers.
> good idea, I can add them in serial_core.c

That would be great. Thanks Richard!

Bye,
-- 
Nicolas Ferre
