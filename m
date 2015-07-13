From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jul 2015 14:29:46 +0200
Subject: [PATCH v3 2/4] dt-bindings: brcmstb-gpio: document properties for
 wakeup
In-Reply-To: <1434589243-502-3-git-send-email-gregory.0xf0@gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
 <1434589243-502-3-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdY5YH7MwGxA_UFg1bzwojT6XouBErBm86PtL_8RCSej0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 3:00 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> Some brcmstb GPIO controllers can be used to wake from suspend, so use
> the de facto standard property 'wakeup-source' to mark the nodes of
> controllers with that capability.
>
> Also document interrupts-extended, which will be used for wakeup
> handling because the interrupt parent for the wake IRQ is different
> from the regular IRQ.
>
> While we're at it, a few more fixes: We don't actually use the
> "interrupt-names" property, so remove it from the listed optional
> properties and from the examples.  And since we're modifying the
> examples, also follow Brian's suggestions to:
> - change #gpio-cells, #interrupt-cells, and brcm,gpio-bank-widths from
>   hex to dec
> - use phandles
>
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> v3: Update per Brian's suggestions described in above message.

I'm very uncertain regarding these interrupts-extended etc.

Can someone who understands that ACK this?

E.g. Grant Likely, Bj?rn Helgaas, Rob Herring.

Yours,
Linus Walleij
