From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 23:15:54 +0200
Subject: [PATCH] pinctrl: mediatek: include chained_irq.h header
In-Reply-To: <20180724115722.1274065-1-arnd@arndb.de>
References: <20180724115722.1274065-1-arnd@arndb.de>
Message-ID: <CACRpkdYHhS7sPY6RqMNUSZ+otnoGPkBVgcfT20B-jscemnmotQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 1:57 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Some randconfig builds fail in the mtk-eint driver:
>
> drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_handler':
> drivers/pinctrl/mediatek/mtk-eint.c:324:2: error: implicit declaration of function 'chained_irq_enter'; did you mean 'rcu_irq_enter'? [-Werror=implicit-function-declaration]
>   chained_irq_enter(chip, desc);
>   ^~~~~~~~~~~~~~~~~
>   rcu_irq_enter
> drivers/pinctrl/mediatek/mtk-eint.c:367:2: error: implicit declaration of function 'chained_irq_exit'; did you mean 'rcu_irq_exit'? [-Werror=implicit-function-declaration]
>
> The functions are declared in linux/irqchip/chained_irq.h, and including
> that header makes it build in all configurations.
>
> Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied!

Thanks Arnd!

Yours,
Linus Walleij
