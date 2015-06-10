From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 14:43:00 +0200
Subject: [PATCH 05/15] gpio: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-6-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-6-git-send-email-robh@kernel.org>
Message-ID: <CACRpkdZW9YvHGoypLRjwQ_gLtnQso3+XN193ZPy17T+31zm+Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 8:26 PM, Rob Herring <robh@kernel.org> wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
>
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: linux-tegra at vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
