From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Jun 2017 11:05:33 +0200
Subject: [PATCH] pinctrl: bcm2835: Avoid warning from __irq_do_set_handler
In-Reply-To: <1498069204-28154-1-git-send-email-stefan.wahren@i2se.com>
References: <1498069204-28154-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CACRpkdapvL7NLP-mXyrb0W5t08rQRqqiZj7tqRF3zhbEM0L0JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 8:20 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> We get a warning during boot with enabled EARLY_PRINTK that
> we try to set a irq_chip without data. This is caused by ignoring
> the return value of irq_of_parse_and_map(). So avoid calling
> gpiochip_set_chained_irqchip() in error case.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 85ae9e512f43 ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")

Patch applied.

Yours,
Linus Walleij
