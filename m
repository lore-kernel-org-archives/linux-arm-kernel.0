From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Feb 2017 14:08:49 +0000
Subject: [PATCH 2/2 v3] irqchip: add a driver for Cortina Gemini
In-Reply-To: <20170130192849.15876-1-linus.walleij@linaro.org> (Linus
 Walleij's message of "Mon, 30 Jan 2017 20:28:49 +0100")
References: <20170130192849.15876-1-linus.walleij@linaro.org>
Message-ID: <877f5093m6.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30 2017 at  7:28:49 pm GMT, Linus Walleij <linus.walleij@linaro.org> wrote:
> As a part of transitioning the Gemini platform to device tree we
> create this clean, device-tree-only irqchip driver.
>
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Facing the need to support a falling edge in the power controller
>   I went ahead and tested and implemented support for falling edge.
> - Rename register defines with GEMINI_ prefix to avoid namespace
>   clashes with other stuff IRQ.
> ChangeLog v1->v2:
> - Do not call irq_create_mapping() on all hwirqs at probe: this
>   will happen automatically when looking up the IRQs from the
>   device tree and is not needed.
>
> irqchip maintainers: please just apply this when you feel pleased
> with it. These portions are functionally orthogonal to the series,
> it is just in a series for context.

Both patches queued.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
