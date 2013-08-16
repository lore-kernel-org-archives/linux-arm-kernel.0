From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 15:34:45 +0200
Subject: [PATCH] gpio: (gpio-pca953x) move header to linux/platform_data/
In-Reply-To: <1375304231-27281-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1375304231-27281-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Message-ID: <CACRpkdZdeVNtJSmc6Lr6j=oO9FLsAvjyrwhYS0j4OoAEhxCN9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 10:57 PM, Vivien Didelot
<vivien.didelot@savoirfairelinux.com> wrote:

> This patch moves the pca953x.h header from include/linux/i2c to
> include/linux/platform_data and updates existing support accordingly.
>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

On the concept:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But:

>  drivers/gpio/gpio-pca953x.c                 |  2 +-
(...)
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 426c51d..8804aec 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -18,7 +18,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c/pca953x.h>
> +#include <linux/platform_data/pca953x.h>

Why does the GPIO driver need platform data from the
I2C driver???

Can't this just be made to go away?

Yours,
Linus Walleij
