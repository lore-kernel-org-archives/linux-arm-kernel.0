From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Dec 2014 14:32:31 +0100
Subject: [PATCH 5/9] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <1416487023-25426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416487023-25426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <CACRpkdY_DFF8BjwLs5m4fe+-eBjmxYW6z4aU+zxiG+EgZys0+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 1:37 PM, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:

> Driver for Fujitsu MB86S7x SoCs that have a memory mapped GPIO controller.
>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>

This is a very simple MMIO GPIO controller.

Why can this *not* just select GPIO_GENERIC and
use drivers/gpio/gpio-generic.c?

You need a smallish driver making use of the generic
MMIO library, see for example
drivers/gpio/gpio-74xx-mmio.c
or any other driver selecting GPIO_GENERIC.

Yours,
Linus Walleij
