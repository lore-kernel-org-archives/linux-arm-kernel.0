From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 May 2016 11:59:32 +0200
Subject: [PATCH 1/2] pinctrl: nomadik: hide nmk_gpio_get_mode when unused
In-Reply-To: <1462289221-861102-1-git-send-email-arnd@arndb.de>
References: <1462289221-861102-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdaYkALuRLZ2LU-o-H97rvTLdCmqQf8Zs6sy-tjamuunnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 5:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> nmk_gpio_get_mode is only used in one place, and that is conditionally
> compiled if DEBUG_FS is enabled. A recent cleanup has marked the
> definition 'static', which now leads to a warning:
>
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:614:12: error: 'nmk_gpio_get_mode' defined but not used [-Werror=unused-function]
>  static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
>             ^~~~~~~~~~~~~~~~~
>
> Moving the function itself inside the #ifdef shuts it up again.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5e81e0a0913c ("pinctrl: nomadik: use BIT() with offsets consequently")

Patch applied!

Yours,
Linus Walleij
