From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 10:30:20 +0100
Subject: [PATCH v2 4/7] gpio: brcmstb: switch to handle_level_irq flow
In-Reply-To: <20171024195451.30535-5-opendmb@gmail.com>
References: <20171024195451.30535-1-opendmb@gmail.com>
 <20171024195451.30535-5-opendmb@gmail.com>
Message-ID: <CACRpkdYFTi4qspSP_2YL6_GP5DSm5RvjyX9arx4pPy0mhG+Wkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 9:54 PM, Doug Berger <opendmb@gmail.com> wrote:

> Reading and writing the gpio bank status register each time a pending
> interrupt bit is serviced could cause new pending bits to be cleared
> without servicing the associated interrupts.
>
> By using the handle_level_irq flow instead of the handle_simple_irq
> flow we get proper handling of interrupt masking as well as acking
> of interrupts.  The irq_ack method is added to support this.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

Patch applied.

Yours,
Linus Walleij
