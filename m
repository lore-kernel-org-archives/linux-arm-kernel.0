From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 14:57:01 +0200
Subject: [PATCH v2 1/2] pinctrl: sunxi: Add custom irq_domain_ops
In-Reply-To: <1438000918-9026-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1438000918-9026-1-git-send-email-maxime.ripard@free-electrons.com>
 <1438000918-9026-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkda+pUGw=dDA4quMgFW7YJGCKF0ApqXi8Y7ZoYxPQWSZCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 2:41 PM, Maxime Ripard
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
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Patch applied.

Yours,
Linus Walleij
