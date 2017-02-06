From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2017 11:04:52 +0100
Subject: [PATCH] pinctrl: samsung: mark PM functions as __maybe_unused
In-Reply-To: <20170201161636.2109091-1-arnd@arndb.de>
References: <20170201161636.2109091-1-arnd@arndb.de>
Message-ID: <CACRpkdYBL_4caeSkD4aXqGCJ0XF=S_pQ24J8pBPCacDyzdow0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 5:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The rework of the suspend/resume handling uses the wrong #ifdef check, leading
> to a build warning without CONFIG_PM_SLEEP:
>
> drivers/pinctrl/samsung/pinctrl-samsung.c:1142:12: error: 'samsung_pinctrl_resume' defined but not used [-Werror=unused-function]
> drivers/pinctrl/samsung/pinctrl-samsung.c:1092:12: error: 'samsung_pinctrl_suspend' defined but not used [-Werror=unused-function]
>
> Using a __maybe_unused annotation instead of the #ifdef is a simple way to
> avoid this problem class.
>
> Fixes: 2b24efa8e5c5 ("pinctrl: samsung: Replace syscore ops with standard platform device pm_ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Marek's ACK.

Yours,
Linus Walleij
