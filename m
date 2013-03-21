From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 19:02:57 +0100
Subject: [PATCH 03/11] ARM: timer-sp: convert to use CLKSRC_OF init
In-Reply-To: <1363820051-24428-4-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZCF1KXgGXw2Hj91duGd6kZR8JW0CBhKHRLeXjnfFO7+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 11:54 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> This adds CLKSRC_OF based init for sp804 timer. The clock initialization is
> refactored to support retrieving the clock(s) from the DT.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
(...)
> @@ -186,6 +201,57 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
>         evt->irq = irq;
>         evt->cpumask = cpu_possible_mask;
>
> +       writel(0, clkevt_base + TIMER_CTRL);
> +

Wait, patch 1/11 depends on this being done first, right?

So patch 1/11 has to be moved after this one in the series
to avoid bisectability problems?

Apart from that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
