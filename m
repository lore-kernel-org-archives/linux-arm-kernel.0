From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Feb 2016 14:17:41 +0100
Subject: [PATCH v2 5/5] pinctrl: sunxi: Use pin number when calling
 sunxi_pmx_set
In-Reply-To: <1454448113-18810-6-git-send-email-k@japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-6-git-send-email-k@japko.eu>
Message-ID: <CACRpkdbc0SfKiCGwUGA2fAPPsUhGv=qGV607Lht6ByYKKgTHjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 10:21 PM, Krzysztof Adamski <k@japko.eu> wrote:

> sunxi_pmx_set accepts pin number and then calculates offset by
> subtracting pin_base from it. sunxi_pinctrl_gpio_get, on the other hand,
> gets offset so we have to convert it to pin number so we won't get
> negative value in sunxi_pmx_set.
>
> This was only used on A10 so far, where there is only one GPIO chip with
> pin_base set to 0 so it didn't matter. However H3 also requires this
> workaround but have two pinmux sections, triggering problem for PL port.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Waiting for Maxime to review this. I guess this patch can be merged
independently of the other patches?

Yours,
Linus Walleij
