From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Dec 2015 14:45:32 +0100
Subject: [PATCH] drivers/misc: make arm-charlcd.c explicitly non-modular
In-Reply-To: <1450055234-418-1-git-send-email-paul.gortmaker@windriver.com>
References: <1450055234-418-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdYpG-vOjo_A9riUda_HFOYqTroOkJx15MoVUggdVh3Cuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 2:07 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
>
> drivers/misc/Kconfig:config ARM_CHARLCD
> drivers/misc/Kconfig:   bool "ARM Ltd. Character LCD Driver"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and this driver did not have a ".remove"
> function coded for non-modular drivers either.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> We don't replace module.h with init.h since the file already has that.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I would consider the modular code a copy/paste error. Unfortunately
not uncommon in the kernel :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this and keeping the kernel clean.

Yours,
Linus Walleij
