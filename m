From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Aug 2012 11:05:03 +0200
Subject: [PATCH 12/14] MTD: atmel nand: fix gpio missing request
In-Reply-To: <1344603731-32667-12-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-12-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdanYZ3CFjFYzeBZanJaCsK6+YGLETRV3wPu8BTLq6D=FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> without this the gpio will not be muxed as a gpio by the current custom pinmux
> or later by the pinctrl
(...)
> +       if (gpio_is_valid(host->board.det_pin))
> +               gpio_free(host->board.det_pin);
> +
> +       if (gpio_is_valid(host->board.enable_pin))
> +               gpio_free(host->board.enable_pin);
> +
> +       if (gpio_is_valid(host->board.rdy_pin))
> +               gpio_free(host->board.rdy_pin);
> +

If you use devm_gpio_request() you can probably get rid of this block of
code, but no big deal so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
