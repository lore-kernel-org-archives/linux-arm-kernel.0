From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 14:04:33 +0200
Subject: [PATCH] gpio: bcm-kona: fix bcm_kona_gpio_reset() warnings
In-Reply-To: <1465316537-8403-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465316537-8403-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdZ-s7CzSrp7VNq8KGJbbxSDcJ5aYEmwSARQ3iKPrb++ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 6:22 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The bcm_kona_gpio_reset() calls bcm_kona_gpio_write_lock_regs()
> with what looks like the wrong parameter. The write_lock_regs
> function takes a pointer to the registers, not the bcm_kona_gpio
> structure.
>
> Fix the warning, and probably bug by changing the function to
> pass reg_base instead of kona_gpio, fixing the following warning:
>
> drivers/gpio/gpio-bcm-kona.c:550:47: warning: incorrect type in argument 1 (different address spaces)
> drivers/gpio/gpio-bcm-kona.c:550:47:    expected void [noderef] <asn:2>*reg_base
> drivers/gpio/gpio-bcm-kona.c:550:47:    got struct bcm_kona_gpio *kona_gpio
> drivers/gpio/gpio-bcm-kona.c:554:47: warning: incorrect type in argument 1 (different address spaces)
> drivers/gpio/gpio-bcm-kona.c:554:47:    expected void [noderef] <asn:2>*reg_base
> drivers/gpio/gpio-bcm-kona.c:554:47:    got struct bcm_kona_gpio *kona_gpio
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Patch applied with the ACKs and tagged for stable.

Yours,
Linus Walleij
