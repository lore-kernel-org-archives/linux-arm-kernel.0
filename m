From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:35:49 +0200
Subject: [PATCH v2] pinctrl: sunxi: Fix recursive dependency
In-Reply-To: <1400770032-8774-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400770032-8774-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZ2x_zvZ13kp7oJMd5D5dYcBR03hkR9oCC879-Bk+AZgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 4:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Fix the following configuration error:
> drivers/pinctrl/sunxi/Kconfig:3:error: recursive dependency detected!
> drivers/pinctrl/sunxi/Kconfig:3:        symbol PINCTRL_SUNXI is selected by PINCTRL_SUN4I_A10
> drivers/pinctrl/sunxi/Kconfig:9:        symbol PINCTRL_SUN4I_A10 default value contains PINCTRL_SUNXI
>
> Add a new intermedia PINCTRL_SUNXI_COMMON, that superseeds the PINCTRL_SUNXI
> one.
>
> We still need to keep PINCTRL_SUNXI at the moment in order to preserve
> bisectability. Indeed, during that merge window, we also introduced the
> MACH_SUN* symbols. Since it's going through different trees, we can't rely on
> the fact that the options will be there, while ARCH_SUNXI still select
> PINCTRL_SUNXI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Or bah, I just applied this then.

Yours,
Linus Walleij
