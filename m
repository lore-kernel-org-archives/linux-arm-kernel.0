From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jul 2013 11:01:17 +0200
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
In-Reply-To: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
Message-ID: <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Mon, Jul 29, 2013 at 9:52 AM, Paul Walmsley <paul@pwsan.com> wrote:

> your commit 0e970cec05635adbe7b686063e2548a8e4afb8f4 ("gpio/omap: don't
> create an IRQ mapping for every GPIO on DT") breaks the boot on the
> OMAP5912 OSK:

I'm contemplating just reverting this whole series, as I didn't like
the approach from the beginning and it has exploded in exactly
the way I thought it would.

If we revert these three patches:

commit 949eb1a4d29dc75e0b5b16b03747886b52ecf854
"gpio/omap: fix build error when OF_GPIO is not defined."
commit b4419e1a15905191661ffe75ba2f9e649f5d565e
"gpio/omap: auto request GPIO as input if used as IRQ via DT"
commit 0e970cec05635adbe7b686063e2548a8e4afb8f4
"gpio/omap: don't create an IRQ mapping for every GPIO on DT"

Does the OMAP1 boot again after this?

I think it's a way better idea to proceed with input-hogs on the gpiochip
DT node and use that to get auto-request on the GPIO lines that
will be used as IRQs only.

Yours,
Linus Walleij
