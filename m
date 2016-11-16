From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Nov 2016 20:54:10 +0100
Subject: [PATCH] pinctrl: sunxi: fix theoretical uninitialized variable
 access
In-Reply-To: <20161116141841.2030776-1-arnd@arndb.de>
References: <20161116141841.2030776-1-arnd@arndb.de>
Message-ID: <CACRpkdYS_C7FVT7LqBsC1izjJJn_GB1Dc6FEe-XBObfGXuVi9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 3:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> gcc warns about a  way that it could use an uninitialized variable:
>
> drivers/pinctrl/sunxi/pinctrl-sunxi.c: In function 'sunxi_pinctrl_init':
> drivers/pinctrl/sunxi/pinctrl-sunxi.c:1191:8: error: 'best_div' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> This cannot really happen except if 'freq' is UINT_MAX and 'clock' is
> zero, and both of these are forbidden. To shut up the warning anyway,
> this changes the logic to initialize the return code to the first
> divider value before looking at the others.
>
> Fixes: 7c926492d38a ("pinctrl: sunxi: Add support for interrupt debouncing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
