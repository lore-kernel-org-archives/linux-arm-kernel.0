From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 18 Jun 2012 14:29:07 -0300
Subject: [PATCH] sound/gpio: of_get_named_gpio() return -EPROBE_DEFER if
 GPIO deferred
In-Reply-To: <1340040176-16553-1-git-send-email-stigge@antcom.de>
References: <1340040176-16553-1-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30E6GAc4p_G7vZBUDFqdWy+ay0ZP9dGCJ586VysOLe66Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 2:22 PM, Roland Stigge <stigge@antcom.de> wrote:
> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
> respective GPIO is not (yet) available. This is useful if driver's probe()
> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
> can be probed again later on.
>
> The function still returns -EINVAL on other errors (parse error or node doesn't
> exist). This way, the case of an optional/intentionally missing GPIO is handled
> appropriately.
>
> For this change, two sound drivers (tegra_{alc5632,wm8903}) need to be
> adjusted.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
