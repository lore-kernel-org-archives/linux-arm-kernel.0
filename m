From: carlo@caione.org (Carlo Caione)
Date: Tue, 2 Jun 2015 11:34:12 +0200
Subject: [PATCH 2/2] pinctrl: dt-binding: Extend meson documentation with
 GPIO IRQs support
In-Reply-To: <CACRpkdZQU8kRnxqg2AA0JDYOp8unNEj77M5-sVL2r+QGznmnBQ@mail.gmail.com>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-3-git-send-email-carlo@caione.org>
 <CACRpkdZQU8kRnxqg2AA0JDYOp8unNEj77M5-sVL2r+QGznmnBQ@mail.gmail.com>
Message-ID: <CAOQ7t2af50CYrARRPf38sPmK7zB=V9n05vnsREOJ8Nypntw6xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 4:04 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 25, 2015 at 1:00 PM, Carlo Caione <carlo@caione.org> wrote:
>
>> From: Beniamino Galvani <b.galvani@gmail.com>
>>
>> Extend the pinctrl binding documentation with the support for external
>> GPIO interrupts.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> (...)
>> + - interrupts: specifies the GPIO IRQ numbers on the GIC (GPIO_IRQ#)
>
> Write that this GPIO only support as many IRQs as you supply
> to the controller.

Ok.

>>         pinctrl: pinctrl at c1109880 {
>>                 compatible = "amlogic,meson8-pinctrl";
>> +               reg-names = "irq";
>
> Why? I thought this was the registers for the whole pin controller.

This register is only used to control the GPIO IRQs. All the muxing
and the basic GPIO control is done using the reg property in the
subnodes (banks).

-- 
Carlo Caione
