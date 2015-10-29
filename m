From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 14:33:34 +0100
Subject: [PATCH 1/2] pinctrl: uniphier: enable UniPhier SoCs pinctrl
 drivers by default
In-Reply-To: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdY4hs_7dE2KicDeUj7hvbKmHu3pcwQO3eshTtSmzH2PGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 3:28 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Add "default y" to the Kconfig rather than adding entries into
> arch/arm/configs/multi_v7_defconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

(...)
> config PINCTRL_UNIPHIER_PH1_LD4
>         tristate "UniPhier PH1-LD4 SoC pinctrl driver"
> +       default y
>         select PINCTRL_UNIPHIER_CORE

Why is it not default y if <PH1_LD4_SOC_THING>?

So it is only turned on if the corresponding SoC is selected?

Or don't you have symbols like that?

ARM SoC folks: can you ACK this patch indicating that this is the way
you wanna handle this?

Yours,
Linus Walleij
