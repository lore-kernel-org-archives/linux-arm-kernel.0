From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 09:32:55 +0200
Subject: [PATCH] pinctrl: at91: Use generic irq_{request,
 release}_resources()
In-Reply-To: <1439818336-31230-1-git-send-email-geert+renesas@glider.be>
References: <1439818336-31230-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CACRpkdbPt4rZF0gvsCkz20qftRCkMeiZ0vP-OOn2SEjFuEFcPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 3:32 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The at91-specific irq_{request,release}_resources() callbacks are
> identical to the generic ones, modulo the bug fix in 5b76e79c77264899
> ("gpiolib: irqchip: prevent driver unloading if gpio is used as irq
> only").
>
> Until commit 8b67a1f0ad1f260f ("gpio: don't override irq_*_resources()
> callbacks"), the buggy at91-specific callbacks were never used, though.
>
> Hence drop the at91-specific ones in favor of the generic ones.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.

Right thing to do so patch applied.

Yours,
Linus Walleij
