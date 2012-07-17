From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 20:24:18 +0200
Subject: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
In-Reply-To: <1340836334-20427-1-git-send-email-stigge@antcom.de>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdYBBa8BZMeGK0kiXNysn_ErpyKhTtbK8yFxf+JyMSndFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 12:32 AM, Roland Stigge <stigge@antcom.de> wrote:

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

Patch applied, if all gpio stuff shall defer properly in v3.6 we need this
so let's do some testing in -next!

Would be nice to get some ACK besides my own...

Yours,
Linus Walleij
