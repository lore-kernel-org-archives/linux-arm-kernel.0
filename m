From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Mar 2014 08:58:30 +0200
Subject: [PATCH] gpio: unmap gpio irqs properly
In-Reply-To: <CAAVeFu+Z33toX=ye7yncE+HhsymKO114QtD_OZsACDQdm69N=g@mail.gmail.com>
References: <1396035858-23758-1-git-send-email-linus.walleij@linaro.org>
 <CAAVeFu+Z33toX=ye7yncE+HhsymKO114QtD_OZsACDQdm69N=g@mail.gmail.com>
Message-ID: <CACRpkdZ9=tUg62Au3MNyamT4QgYzFDsA11_o_0VADa=4to0=Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 29, 2014 at 5:27 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Sat, Mar 29, 2014 at 4:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> +static void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq)
>> +{
>> +#ifdef CONFIG_ARM
>> +       set_irq_flags(irq, 0);
>> +#endif
>
> Just curious here, why is a special case needed for ARM? I would not
> expect architecture-specific code on gpiolib, but I'm sure you have
> your reasons for that.

This is open-coded like this in all ARM-applicable drivers so I'm
just refactoring really.

I don't really know why but I was under the impression that this
ARM-specific function exists because the IRQ implementations in
the different archs have never really converged.

Yours,
Linus Walleij
