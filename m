From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 06:05:13 -0700
Subject: [PATCH 16/19] mfd: Provide the tc3589x with its own IRQ domain
In-Reply-To: <1347016499-29354-17-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaAwaUwr9njGCRDssyNVFv8TgeZeKVeFj=MUA_fA_jesw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In preparation for Device Tree enablement all IRQ controllers
> should control their own IRQ domain. This patch provides just
> that.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

It's always nice to have irqdomains added, excellent patch!

> +       if (base) {
> +               tc3589x->domain = irq_domain_add_legacy(
> +                       NULL, TC3589x_NR_INTERNAL_IRQS, base,
> +                       0, &tc3589x_irq_ops, tc3589x);
>         }
> +       else {
> +               tc3589x->domain = irq_domain_add_linear(
> +                       NULL, TC3589x_NR_INTERNAL_IRQS,
> +                       &tc3589x_irq_ops, tc3589x);
> +       }

This is especially elegant, well done.
Not my subsystem, but FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
