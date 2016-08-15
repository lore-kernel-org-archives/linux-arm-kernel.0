From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 15 Aug 2016 20:34:51 +0900
Subject: [PATCH] pinctrl: exynos: remove duplicate calls in irq handler
In-Reply-To: <1471256227-6282-1-git-send-email-strongbox8@zoho.com>
References: <1471256227-6282-1-git-send-email-strongbox8@zoho.com>
Message-ID: <CA+Ln22HWHRROhzVQo4ptsKr5xNyMh=dnuCO7FEG1BsinpPg8MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-08-15 19:17 GMT+09:00 perr <strongbox8@zoho.com>:
> Because chained_irq_enter() has already called chip->irq_mask() and
> chip->irq_ack(), also chained_irq_exit() will call chip->irq_unmask(),
> so it's not necessary to call chip->irq_*() here.
>
> Signed-off-by: perr <strongbox8@zoho.com>
>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>

Indeed, nice finding. Thanks!

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
