From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 14:00:43 +0100
Subject: [PATCH] gpio: davinci: add support for pinmux gpio ranges
In-Reply-To: <1516576180-1467-1-git-send-email-david@lechnology.com>
References: <1516576180-1467-1-git-send-email-david@lechnology.com>
Message-ID: <CACRpkdaTcCo93xqDNy7ixvF=aeF1VbML+OaJY8rtcEJZswXFbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 12:09 AM, David Lechner <david@lechnology.com> wrote:

> This adds support for the pinmux gpio ranges feature to the DaVinci gpio
> driver. Only device tree is supported since the non-DT boards don't
> use a generic pinmux controller.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <david@lechnology.com>

Nice, patch applied!

> +       if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
> +               chips->chip.request = gpiochip_generic_request;
> +               chips->chip.free = gpiochip_generic_free;
> +       }

If the backing pin controller can do things like debounce
or open drain pin control, consider using also the
gpiochip_generic_config() callback in the future.

Yours,
Linus Walleij
