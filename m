From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Oct 2012 19:22:46 +0200
Subject: [PATCH] ARM: U300: bump IRQs to offset 32
In-Reply-To: <1350491679-32685-1-git-send-email-linus.walleij@stericsson.com>
References: <1350491679-32685-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdbvYGb8b_4Lg-cXm5o+iXQZOQ48ffyW6vhkiPtgL6Vt1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 6:34 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The U300 IRQs were bumped once to offset to 1 (in order to avoid
> using IRQ 0 which is now NO_IRQ). This was OK as we were still
> passing the number of irqs in the .nr_irqs field of the machine,
> with descriptors allocated at boot time.
>
> However .nr_irqs should be 0, leading the system to reserve the
> first 16 IRQs. Then the VIC driver will complain that IRQs 1
> thru 15 are pre-allocated, so to avoid this and use free
> descriptors, move all IRQs up to offset 32.
>
> This will all be done away with as we migrate to device tree,
> so it is an interim solution.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Oooups, requsting an ACK from the ARM SoC maintainers to
take this in through the pinctrl tree. Later patches also touch this
file so to avoid unnecessary conflicts it's better to bring it in there.

Yours,
Linus Walleij
