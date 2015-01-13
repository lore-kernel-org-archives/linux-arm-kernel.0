From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 07:09:20 +0100
Subject: [PATCH v3 14/21] ARM: imx6: convert GPC to stacked domains
In-Reply-To: <1421087187-26988-15-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
 <1421087187-26988-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdYHnBtP39xpEkjdibpijGip0Y3+YLvEA8KUGfentKbZ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 7:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> IMX6 has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
>
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
>
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the fact that the GPC block is actually the first
> interrupt controller in the chain, kernels with this patch
> applied wont have any suspend-resume facility when booted
> with old DTs, and old kernels with updated DTs won't even boot.
>
> Tested-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

(...)

> +static int imx_gpc_domain_alloc(struct irq_domain *domain,
> +                                 unsigned int virq,

Nutcase nitpick on this nice patch series: every time I see "virq" my
OCD triggers, as I think the "v" in "virq" stand for virtual. These irqs
are no more virtual than any other Linux irq numbers, hwirq is
more to the point.

I just refer to these as "irq" (sans "v") in any code I write.

Yours,
Linus Walleij
