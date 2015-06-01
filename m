From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 16:04:04 +0200
Subject: [PATCH 2/2] pinctrl: dt-binding: Extend meson documentation with
 GPIO IRQs support
In-Reply-To: <1432551641-3256-3-git-send-email-carlo@caione.org>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-3-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdZQU8kRnxqg2AA0JDYOp8unNEj77M5-sVL2r+QGznmnBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 1:00 PM, Carlo Caione <carlo@caione.org> wrote:

> From: Beniamino Galvani <b.galvani@gmail.com>
>
> Extend the pinctrl binding documentation with the support for external
> GPIO interrupts.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
(...)
> + - interrupts: specifies the GPIO IRQ numbers on the GIC (GPIO_IRQ#)

Write that this GPIO only support as many IRQs as you supply
to the controller.

>         pinctrl: pinctrl at c1109880 {
>                 compatible = "amlogic,meson8-pinctrl";
> +               reg-names = "irq";

Why? I thought this was the registers for the whole pin controller.

Yours,
Linus Walleij
