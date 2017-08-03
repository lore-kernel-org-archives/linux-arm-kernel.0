From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Aug 2017 23:31:46 +0200
Subject: [PATCH] pinctrl: sirf: atlas7: fix of_irq_get() error check
In-Reply-To: <20170730193855.099325987@cogentembedded.com>
References: <20170730193855.099325987@cogentembedded.com>
Message-ID: <CACRpkdbW2efOy+qH+JPHYnbaUHkf2eqcWGm66C9a1K+uj_QNdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 30, 2017 at 9:38 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> of_irq_get() may return  any negative error number as well as 0 on failure,
> while the driver only checks for -EPROBE_DEFER, blithely continuing with
> the call to gpiochip_set_chained_irqchip() -- that function expects the
> parent IRQ as *unsigned int*, so would probably do nothing  when a large
> IRQ number resulting from a conversion of a negative error number is passed
> to it, however passing 0 would probably work but the driver won't receive
> valid GPIO bank interrupts.
>
> Check for 'ret <= 0' instead and return -ENXIO from the driver's probe iff
> of_irq_get() returned 0.
>
> Fixes: f9367793293d ("pinctrl: sirf: add sirf atlas7 pinctrl and gpio support")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Patch applied!

Yours,
Linus Walleij
