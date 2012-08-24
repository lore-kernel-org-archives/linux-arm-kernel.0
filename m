From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 24 Aug 2012 18:38:39 +0530
Subject: [PATCH] ARM: ux500: set proper GIC flags
In-Reply-To: <1345813264-4896-1-git-send-email-linus.walleij@stericsson.com>
References: <1345813264-4896-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAMQu2gx9kU4sPL5-TsJTq_2pUvm3Jm6rNWS=XYQJihTUpm1nHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 6:31 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The Ux500 will be able to wake up on any IRQ, so flag it with
> IRQCHIP_SKIP_SET_WAKE, and we want to mask off the IRQs when
> going to suspend to avoid transient effects so also flag
> this with IRQCHIP_MASK_ON_SUSPEND.
>
> Cc: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> index e2360e7..2957432 100644
> --- a/arch/arm/mach-ux500/cpu.c
> +++ b/arch/arm/mach-ux500/cpu.c
> @@ -51,6 +51,8 @@ void __init ux500_init_irq(void)
>         void __iomem *dist_base;
>         void __iomem *cpu_base;
>
> +       gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
> +
With this patch, you should no longer need the dummy set_irq_wake()
patch which I was form
you for ux500.

Regards
Santosh
