From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2018 16:20:01 +0200
Subject: [PATCH] gpio: uniphier: set legitimate irq trigger type in
 .to_irq hook
In-Reply-To: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYKO6BArTXzk9ms70AJrNC4kAk_ZyaNHUGJANwuBqqUtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 7:27 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> If a GPIO chip is a part of a hierarchy IRQ domain, there is no
> way to specify the trigger type when gpio(d)_to_irq() allocates an
> interrupt on-the-fly.
>
> Currently, uniphier_gpio_to_irq() sets IRQ_TYPE_NONE, but it causes
> an error in the .alloc() hook of the parent domain.
> (drivers/irq/irq-uniphier-aidet.c)
>
> Even if we change irq-uniphier-aidet.c to accept the NONE type,
> GIC complains about it since commit 83a86fbb5b56 ("irqchip/gic:
> Loudly complain about the use of IRQ_TYPE_NONE").
>
> Instead, use IRQ_TYPE_LEVEL_HIGH as a temporary value when an irq
> is allocated.  irq_set_irq_type() will override it when the irq is
> really requested.
>
> Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
> Reported-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Patch applied for fixes!

Yours,
Linus Walleij
