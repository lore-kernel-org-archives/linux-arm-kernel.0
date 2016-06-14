From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2016 08:55:05 +0200
Subject: [PATCH 1/2] pinctrl: fix incorrect inline keyword in multiple
 drivers
In-Reply-To: <1465831250-2689101-1-git-send-email-arnd@arndb.de>
References: <1465831250-2689101-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZSqFfp6v-jk1Xv3RVK4xz-Di_4rj_TmHnsmFRPswSB7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 5:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When building with 'make W=1', we get harmless warnings about
> five drivers in drivers/pinctrl, which all contain a copy of
> the same line:
>
> drivers/pinctrl/freescale/pinctrl-imx1-core.c:160:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
>
> This replaces the somewhat nonstandard 'static const inline'
> with 'static inline const', which has the same meaning but
> does not cause this warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
