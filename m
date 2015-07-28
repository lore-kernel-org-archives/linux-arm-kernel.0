From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Jul 2015 12:15:59 +0200
Subject: [PATCH v3] pinctrl: kill off set_irq_flags usage
In-Reply-To: <1438030523-15853-10-git-send-email-robh@kernel.org>
References: <1438030523-15853-1-git-send-email-robh@kernel.org>
 <1438030523-15853-10-git-send-email-robh@kernel.org>
Message-ID: <CACRpkdZO3VL6-te9U5oHjGQot3faefyH4k=LPWasRAAUZxP1JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 10:55 PM, Rob Herring <robh@kernel.org> wrote:

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
> users also modify IRQ_NOPROBE and this has been maintained although it
> is not clear that is really needed. There appears to be a great deal of
> blind copy and paste of this code.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---
> Thomas asked that this be merged thru subsystem trees instead of arm-soc,
> so please apply this to your tree.

Patch applied, and thanks for driving this.

Yours,
Linus Walleij
