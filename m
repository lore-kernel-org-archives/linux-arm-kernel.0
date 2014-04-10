From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 20:49:41 +0200
Subject: [PATCH] i2c: nomadik: Fixup system suspend
In-Reply-To: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
References: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdb8VJ_Qqype4uP_YJ5=RncJndFUZv_yDxmZwq5S=_yZ2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> For !CONFIG_PM_RUNTIME, the device were never put back into active
> state while resuming.
>
> For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
> while we were about to handle it at suspend late, which is just too
> optimistic.
>
> Even if the driver uses pm_runtime_put_sync() after each tranfer to
> return it's runtime PM resources, there are no guarantees this will
> actually mean the device will inactivated. The reason is that the PM
> core will prevent runtime suspend during system suspend, and thus when
> a transfer occurs during the early phases of system suspend the device
> will be kept active after the transfer.
>
> To handle both issues above, use pm_runtime_force_suspend|resume() from
> the system suspend|resume callbacks.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
