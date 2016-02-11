From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Feb 2016 14:30:57 +0100
Subject: [PATCH v4 5/5] pinctrl: sunxi: Use pin number when calling
 sunxi_pmx_set
In-Reply-To: <1455029929-18547-6-git-send-email-k@japko.eu>
References: <1455029929-18547-1-git-send-email-k@japko.eu>
 <1455029929-18547-6-git-send-email-k@japko.eu>
Message-ID: <CACRpkdbKVVxFs7aSE_2gRgtNSUJ0hsE++FATyD6uWcwxXvTjTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 9, 2016 at 3:58 PM, Krzysztof Adamski
<krzysztof.adamski@tieto.com> wrote:

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
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

OK applied this version that has Maxime's ACK.

Yours,
Linus Walleij
