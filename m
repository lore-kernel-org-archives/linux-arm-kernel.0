From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 15:14:12 +0200
Subject: [PATCH] pinctrl: nomadik: fix incorrect type in return expression
In-Reply-To: <1501822187-25303-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501822187-25303-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYtgZ-iMeDBXYhtW94Vkvcj81QhqAfz3z-zajCNJV7j3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 6:49 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Sparse reports "warning: incorrect type in return expression (different
> address spaces)" because nmk_gpio_populate_chip() is supposed to return
> (struct nmk_gpio_chip *) whereas devm_ioremap_resource() returns
> (void __iomem *).  ERR_CAST() is needed to fix the warning.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
