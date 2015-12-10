From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 18:31:25 +0100
Subject: [PATCH v3 0/6] pinctrl: meson: enable support for external GPIO
 interrupts
In-Reply-To: <1448987062-31225-1-git-send-email-carlo@caione.org>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdZ+kmyRKR9RwcLzAXWsUDGVniAhoidEp-kbwhoVEDhPvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2015 at 5:24 PM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> In Meson SoCs we have 8 independent GPIO interrupts that can be programmed to
> use any of the GPIOs in the chip as interrupt source.
>
> These GPIOs are managed by GIC but they can be conditioned (and enabled) by
> some registers external to the GIC.
>
> GPIOs |--[mux1 or mux2]--[polarity]--[filter]--[edge_select]--> GIC
>
> Changelog:
>
> * V2:
>     - Introduced .irq_request_resources() and .irq_release_resources()
>     - s/virq/irq/ and s/pin/hwirq/
>     - Moved to the new irq_fwspec
>
> * V3:
>     - EXPORT_SYMBOL_GPL for of_irq_find_parent()
>     - split GPIO management and irqchip side
>     - the GIC IRQs list is not kept as set of fwspecs. it's now a regular
>       integer array.
>     - irq_of_phandle_args_to_fwspec discarded

I don't know where this patch set is standing but I get the impression that it
still needs revising so waiting for a v4.

Given the complex nature of the IRQs I will probably want Marc to provide
his Review/ACK before applying.

Yours,
Linus Walleij
