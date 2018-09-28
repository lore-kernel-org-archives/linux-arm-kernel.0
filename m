From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2018 09:27:36 +0200
Subject: [PATCH] pinctrl: mediatek: mark dummy helpers as 'static inline'
In-Reply-To: <20180926193818.2481220-1-arnd@arndb.de>
References: <20180926193818.2481220-1-arnd@arndb.de>
Message-ID: <CACRpkdY-9VhNJdh2FtzRUiwZTUfKQ+KKM5cFA2LuCwhCC+Ao6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 9:38 PM Arnd Bergmann <arnd@arndb.de> wrote:

> mtk_eint_set_debounce and mtk_eint_find_irq are defined as stub functions
> in a header file, but without marking them as 'static inline', we get
> a copy for each file that includes the header:
>
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_set_debounce':
> pinctrl-mtk-common-v2.c:(.text+0x134): multiple definition of `mtk_eint_set_debounce'
> drivers/pinctrl/mediatek/pinctrl-moore.o:pinctrl-moore.c:(.text+0x7d0): first defined here
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_find_irq':
> pinctrl-mtk-common-v2.c:(.text+0x13c): multiple definition of `mtk_eint_find_irq'
>
> Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
