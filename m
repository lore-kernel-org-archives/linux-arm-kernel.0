From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Oct 2015 16:20:42 +0100
Subject: [PATCH] gpio: zynq: Implement irq_(request|release)_resources
In-Reply-To: <562FBA60.70002@ti.com>
References: <1445607381-7794-1-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkda4QKEJvwkwGLS7OLTP8Nxu5W05tzbcFXA_FPnBsFtKhw@mail.gmail.com>
 <562FA3EE.5040408@ti.com>
 <CACRpkdYjNWiEdM8kthMXhGXBPYE74hy_xa7bBB6XQrAOaBnehA@mail.gmail.com>
 <562FBA60.70002@ti.com>
Message-ID: <CACRpkdZpEh=Z89M3SPxNzstUYqB8BpzL_PMgRiPQN2C+WFq5KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 6:54 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> [Me]
>> Do you mean that these functions contain calls to non-atomic
>> functions?
>>
>
> Oh. No, I have to be more specific :(
> if GPIOx driver defines custom .irq_(request|release)_resources() callbacks
> they will *overwrite* standard GPIOirqchip callbacks.
> (commit: 8b67a1f "gpio: don't override irq_*_resources() callbacks")
>
> As result, such GPIOx driver should *re-implement* the same functionality in
> its .irq_(request|release)_resources() callbacks as implemented in
> gpiochip_irq_reqres()/gpiochip_irq_relres().

Yes that goes for all drivers not using gpiochip_add_irqchip().
Not everyone uses that ... and for those supplying their own
implementations of these functions.

Yours,
Linus Walleij
