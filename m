From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 16:03:48 +0100
Subject: [PATCH] pinctrl: rockchip: add irq_enable & irq_disable ops
In-Reply-To: <1488434212-6567-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1488434212-6567-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <CACRpkdYQawufFw+TX8MX0qbAXOy9rJ=uT5qCG8kmfOON2k7yMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 2, 2017 at 6:56 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:

> Currently we are trying to enable/disable the clk of irq's gpio bank when
> unmask/mask irq. But the kernel's "lazy disable approach" will skip masking
> irq when the irq chip doesn't support irq_disable ops.
>
> So we may hit this case:
>         irq_enable-> enable clk
>         irq_disable-> noop
>         irq_enable-> enable clk again
>         irq_disable-> noop
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Heiko, can you look at this patch?

Yours,
Linus Walleij
