From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Feb 2017 16:00:13 +0100
Subject: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
In-Reply-To: <alpine.LNX.2.00.1702051101110.26313@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-4-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1702051101110.26313@T420s>
Message-ID: <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 5, 2017 at 11:03 AM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:

> We need to the remove hwirq 26-28 from DT.
> First one will print this warning while boot.
>
> irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller at 48000000!
(...)
> -                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
> -                                       <26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
> -                                       <27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
> -                                       <28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
> +                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* chained irq PCI A-D */

Sure I can remove them ... just found them in the irqs.h file and thought it
made sense to add them. I'll just cut them.

Since there is actually an internal IRQ controller in the host controller
cascading the four PCI child IRQs that we model as an irqchip, I don't
really see why they have these "PCI B-D" IRQs... anyone has a guess?

Yours,
Linus Walleij
