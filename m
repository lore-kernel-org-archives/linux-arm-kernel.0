From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 14:04:38 +0200
Subject: [PATCH 3/4] pinctrl: sunxi: Add custom irq_domain_ops
In-Reply-To: <1437396074-15791-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
 <1437396074-15791-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdagO0DhB_1KLcKDPJ9RoKx=aiUMLMX59bZOXkA4PcN8cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 2:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The current interrupt parsing code was working by accident, because the
> default was actually parsing the first node of interrupts.
>
> While that was mostly working (and the flags were actually ignored), this
> binding has never been documented, and doesn't work with SoCs that have
> multiple interrupt banks anyway.
>
> Add a proper interrupt xlate function, that uses the same description than
> the GPIOs (<bank> <pin> <flags>), that will make things less confusing.
>
> The EINT number will still be used as the hwirq number, but won't be
> exposed through the DT.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This patch does not apply to the pinctrl devel branch.

Does it need to be rebased or do I need to merge in fixes?

Holding patch 3/4 and 4/4 until this is resolved.

Yours,
Linus Walleij
