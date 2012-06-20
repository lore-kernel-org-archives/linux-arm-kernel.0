From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 10:19:50 +0200
Subject: [PATCH v2] PINCTRL: SiRF: add GPIO and GPIO irq support in CSR
 SiRFprimaII
In-Reply-To: <1340090216-1689-1-git-send-email-Barry.Song@csr.com>
References: <1340090216-1689-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdbZXqiv2maVqaDHX-7AmYZLqRot-F0UX8UWOe3WPA2B7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 9:16 AM, Barry Song <Barry.Song@csr.com> wrote:

> In SiRFprimaII, Each GPIO pin can be configured as input or output
> independently. If a GPIO is configured as input, it can also be
> enabled as an interrupt source (either edge or level triggered).
>
> These pins must be either MUXed as GPIO or other function pads.
>
> Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

This is looking great!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume you will merge this through the ARM SoC tree and the
PrimaII branch? Tell me if you need it to be merged through the
pinctrl tree.

> +/* Pull up/down values */
> +enum sirfsoc_gpio_pull {
> + ? ? ? SIRFSOC_GPIO_PULL_NONE,
> + ? ? ? SIRFSOC_GPIO_PULL_UP,
> + ? ? ? SIRFSOC_GPIO_PULL_DOWN,
> +};

As noted you can use pinconf-generic and friends, but it's definately
not a requirement. You can also do that as a refactoring on top of this
patch if you want to.

Yours,
Linus Walleij
