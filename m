From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 14:15:12 +0200
Subject: [PATCH] gpio: mvebu: Fix cause computation in irq handler
In-Reply-To: <20170712112229.858-1-gregory.clement@free-electrons.com>
References: <20170712112229.858-1-gregory.clement@free-electrons.com>
Message-ID: <CACRpkda6mm8Ogam2vD6LY4XBwzKdSeh8-e5ieUZWtZXnbSrOhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 1:22 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> When switching to regmap, the way to compute the irq cause was
> reorganized. However while doing it, a typo was introduced: a 'xor'
> replaced a 'and'.
>
> This lead to wrong behavior in the interrupt handler ans one of the
> symptom was wrong irq handler called on the Armada 388 GP:
> "->handle_irq():  c016303c,
> handle_bad_irq+0x0/0x278
> ->irq_data.chip(): c0b0ec0c,
> 0xc0b0ec0c
> ->action():   (null)
>    IRQ_NOPROBE set
>  IRQ_NOREQUEST set
> unexpected IRQ trap at vector 00
> irq 0, desc: ee804800, depth: 1, count: 0, unhandled: 0"
>
> Fixes: 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register access")
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied for fixes.

Yours,
Linus Walleij
