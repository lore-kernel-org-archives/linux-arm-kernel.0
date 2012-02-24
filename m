From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 24 Feb 2012 16:07:52 +0530
Subject: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
In-Reply-To: <4F47623E.5060908@ti.com>
References: <4F46C1AF.2040201@ti.com> <20120223230821.GD18185@atomide.com>
 <4F47623E.5060908@ti.com>
Message-ID: <CAC83ZvLm-ruk3pMkeLhiyOMAVVnByk9PPWsM40AyPErSqz=dKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 3:41 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> + Tarun
>
>
> On 2/24/2012 12:08 AM, Tony Lindgren wrote:
>>
>> * Cousson, Benoit<b-cousson@ti.com> ?[120223 14:14]:
>>>
>>> The GPIO driver is still relying on internal OMAP IRQ defines that
>>> are not relevant anymore if OMAP is built with SPARSE_IRQ.
>>
>>
>> Great :)
>>
>>> Please note that this patch is still RFC, because I do not know
>>> how to fix properly the ugly cpu_class_is_omap1 and the dependency
>>> with IH_MPUIO_BASE to detect a MPUIO.
>>
>>
>> Sounds like gpio_to_irq() needs to be set in the
>> arch/arm/*omap*/gpio*.c then.
>
>
> In fact, after a second thought, that might even work for OMAP1 because I'm
> using the proper base (IRQ and GPIO) to convert the IRQ number.
>
>
> static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
> {
>
> ? ? ? ?return gpio_irq - bank->irq_base + bank->chip.base;
> }
>
> But it might be good to test it on OMAP1 platform.
>
>
> Tarun,
>
> Do you have an OMAP1 board to test that.
Yes, I will test on OMAP1 board.
--
Tarun
>
> Regards,
> Benoit
