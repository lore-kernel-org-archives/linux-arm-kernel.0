From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 12 Sep 2013 10:55:27 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <5230AB6E.1070807@ahsoftware.de>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <344239800.bDEkDg48ZQ@avalon>
 <CACRpkdavR=fv+y1RCNfdgQypPuRbO6isOSwGsABDrYiGeMdyZw@mail.gmail.com>
 <52308C91.2000105@ahsoftware.de> <523096FE.8080901@collabora.co.uk>
 <5230AB6E.1070807@ahsoftware.de>
Message-ID: <5231817F.8000901@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.09.2013 19:42, schrieb Alexander Holler:
> Am 11.09.2013 18:14, schrieb Javier Martinez Canillas:

>> So for example in an OMAP board DT you can define something like this:
>>
>> ethernet at 5,0 {
>>          compatible = "smsc,lan9221", "smsc,lan9115";
>>          interrupt-parent = <&gpio6>;
>>          interrupts = <16 8>;
>> };
>>
>> Since each OMAP GPIO bank has 32 GPIO pins, then what you are defining
>> is that
>> the GPIO 176 (5 * 32 + 16) will be mapped as the IRQ line for the
>> ethernet
>> controller.

By the way, how do you define two GPIOs/IRQs from different
gpio-banks/irq-controllers wuth that scheme?

Would that be like below?

 ethernet at 5,0 {
          compatible = "smsc,lan9221", "smsc,lan9115";
          interrupt-parent = <&gpio6>;
          interrupts = <16 8>;
          interrupt-parent = <&gpio7>;
          interrupts = <1 IRQF_TRIGGER_FALLING>; /* GPIO7_1 */
 };

So multiple definitions of interrupt-parent are allowed and the order
does matter? And such does work? Sorry for asking, but I'm relatively
new to DT. ;)

Regards,

Alexander Holler
