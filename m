From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jun 2016 10:53:51 +0200
Subject: [PATCH 0/2] pinctrl: Enable support for external GPIO interrupts
In-Reply-To: <5772301F.3030904@baylibre.com>
References: <5772301F.3030904@baylibre.com>
Message-ID: <CACRpkdZivUN8HKZ7oTDW6C35vSMv6+9G6-8M7=-kJM3B9vmH-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 10:06 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:

> I have another implementation idea about this subject, by using static GPIO-irq
> association in DT instead of using a very complex dynamic allocation.
>
> The idea is to add a simple property :
> irqs-gpios = <>
>
> To map a GPIO to the irqs, then we can either use the DT irq mapping or use the
> gpiolib to_irq() if the gpio is in the table.
>
> The relative drawback is that we will need DT changes to enable routing of a gpio
> to an IRQ, but the complete system is based on a DT description anyway.
>
> In this case, we could use gpiochip_irqchip.
>
> Do you think this structure would be acceptable ?

That depends on:

- A nod from the DT maintainers that this is acceptable from a HW description
  point of view and a simplification that probably all other OS:es
will also want
  to do.

- Rough consensus from the maintainess of the platform that this makes
  sense, do noone appear three months down the road and says "oh wait I
  have this usecase that require us to do this dynamically".

I think the dynamic solution is always more elegant, computers should resolve
complex problems, doing it in DT makes a human do a machine's work which
is as a rule of thumb not a good idea. But there is also the question
of maintenance
cost and what makes sense at a human level so I'm not totally
inflexible on this.

Yours,
Linus Walleij
