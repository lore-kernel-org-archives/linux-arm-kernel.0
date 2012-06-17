From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Jun 2012 20:04:47 +0200
Subject: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER if
 GPIO not yet available
In-Reply-To: <1339927893-8842-1-git-send-email-stigge@antcom.de>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdZeBiTX6hOu_PyrhZ8VA0uD3kz47a1p9Uo30S=w7U2O6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 12:11 PM, Roland Stigge <stigge@antcom.de> wrote:

> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
> respective GPIO is not (yet) available. This is useful if driver's probe()
> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
> can be probed again later on.
>
> The function still returns -EINVAL on other errors (parse error or node doesn't
> exist). This way, the case of an optional/intentionally missing GPIO is handled
> appropriately.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This will work, good work!
Yours,
Linus Walleij
