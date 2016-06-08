From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 10:10:19 +0200
Subject: [PATCH] pinctrl: mediatek: fix suspend/resume timing issue
In-Reply-To: <1464924495-20375-1-git-send-email-hongkun.cao@mediatek.com>
References: <1464924495-20375-1-git-send-email-hongkun.cao@mediatek.com>
Message-ID: <CACRpkdZ18pvNBLp1L4wBh2BnwODaju4mTwCjuK-Bnp-Rc5feqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 5:28 AM,  <hongkun.cao@mediatek.com> wrote:

> From: "hongkun.cao" <hongkun.cao@mediatek.com>
>
> An irq which is a wake up source maybe masked unexpectedly if the wake
> up source irq was triggered after pinctrl irqchip suspend and before
> suspend_device_irqs finished.
> Use *_noirq callbacks to guarantee pinctrl irqchip suspend would be
> called after suspend_devices_irqs.
>
> Signed-off-by: hongkun.cao <hongkun.cao@mediatek.com>

No rreaction from the other maintainers but it looks correct to me
so patch applied.

Yours,
Linus Walleij
