From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jul 2012 23:51:28 +0200
Subject: [PATCH 1/2] gpio/omap: move bank->dbck initialization to
 omap_gpio_mod_init()
In-Reply-To: <1341997995-14020-2-git-send-email-tarun.kanti@ti.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
 <1341997995-14020-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <CACRpkdYdtrAu-GX4F6iv_3VM4DrTAU48ch63SotLybfi8oLffQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 11:13 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:

> Since the bank->dbck initialization in a one time operation there
> is no need to keep this within gpio_debounce(). Therefore, moving
> clk_get(bank->dbck) to omap_gpio_mod_init(). Since the value of
> bank->dbck would be NULL at the beginning, this check has been
> removed.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Applied with Pauld reviewed-by.

Thanks,
Linus Walleij
