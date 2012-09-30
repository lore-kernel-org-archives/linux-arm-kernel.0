From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2012 10:44:17 +0200
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdb+bnCzYV2Dzqou5kGyc1hrh0VT-pYXZm1auu4uik2GNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 1:21 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This reverts commit 6887237cd7da904184dab2750504040c68f3a080.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Why?

It was removed in this commit, is it wrong?

Author: Michel JAOUEN <michel.jaouen@stericsson.com>
Date:   Fri Aug 17 17:28:41 2012 +0200

    spi/pl022: fix spi-pl022 pm enable at probe

    amba drivers does not need to enable pm runtime at probe.
    amba_probe already enables pm runtime.

    This rids this warning in the ux500 boot log:
    ssp-pl022 ssp0: Unbalanced pm_runtime_enable!

    Signed-off-by: Michel JAOUEN <michel.jaouen@stericsson.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Yours,
Linus Walleij
