From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Nov 2018 14:36:55 +0100
Subject: [PATCH] dma: coh901318: Fix a double-lock bug
In-Reply-To: <20181106033348.27361-1-baijiaju1990@gmail.com>
References: <20181106033348.27361-1-baijiaju1990@gmail.com>
Message-ID: <CACRpkdZRRqa6L9wws_5t7WC5Ekdx1NbWUbXdiM7rnHeZpb7Wrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2018 at 4:33 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> The function coh901318_alloc_chan_resources() calls spin_lock_irqsave()
> before calling coh901318_config().
> But coh901318_config() calls spin_lock_irqsave() again in its
> definition, which may cause a double-lock bug.
>
> Because coh901318_config() is only called by
> coh901318_alloc_chan_resources(), the bug fix is to remove the
> calls to spin-lock and -unlock functions in coh901318_config().
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
