From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Mar 2016 10:28:10 +0700
Subject: [PATCH 7/8] drivers/pinctrl: make sunxi/pinctrl-sun9i-a80-r.c
 explicitly non-modular
In-Reply-To: <1456778924-20730-8-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
 <1456778924-20730-8-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdbzwD2bc6tDqkq701Gr8nz60MRzOKQtD5etVx_ifQ3gxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2016 at 3:48 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
>
> drivers/pinctrl/sunxi/Kconfig:config PINCTRL_SUN9I_A80_R
> drivers/pinctrl/sunxi/Kconfig:  def_bool MACH_SUN9I
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
