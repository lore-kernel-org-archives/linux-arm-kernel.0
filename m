From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Feb 2014 15:34:24 +0100
Subject: [PATCH 14/17] i2c: nomadik: Fixup deployment of runtime PM
In-Reply-To: <1391529538-21685-15-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-15-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZwoXf5ovmQEAN6Ugvz91+_i5uGqStR3MGXQeJGHitj3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Since the device is active while a successful probe has been completed,
> the reference counting for the clock will be screwed up and never reach
> zero.
>
> The issue is resolved by implementing runtime PM callbacks and let them
> handle the resources accordingly, including the clock.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hm do I read it right as patch 13 breaks runtime PM by leaving
the device active after probe() and this patch
14 fixes it again? Maybe these two patches should be squashed
then.

Yours,
Linus Walleij
