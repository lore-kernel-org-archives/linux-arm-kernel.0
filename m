From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Mar 2015 11:20:43 +0100
Subject: [PATCH v6 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <1425933902-20652-7-git-send-email-rjui@broadcom.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
 <1425933902-20652-7-git-send-email-rjui@broadcom.com>
Message-ID: <CACRpkdZ1ErfikdF41aANTM-7LE6AExizHtCZTq1_TTxwYjeSQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 9, 2015 at 9:45 PM, Ray Jui <rjui@broadcom.com> wrote:

> This adds the initial support of the Broadcom Cygnus GPIO/PINCONF driver
> that supports all 3 GPIO controllers on Cygnus including the ASIU GPIO
> controller, the chipCommonG GPIO controller, and the always-on GPIO
> controller. Basic PINCONF configurations such as bias pull up/down, and
> drive strength are also supported in this driver.
>
> Pins from the ASIU GPIO controller can be individually muxed to GPIO
> function, through interaction with the Cygnus IOMUX controller
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Dmitry Torokhov <dtor@chromium.org>

Patch applied! But please look at this:

> +#include <linux/gpio.h>

Doesn't just #include <linux/gpio/driver.h> work?

> +static int __init cygnus_gpio_init(void)
> +{
> +       return platform_driver_probe(&cygnus_gpio_driver, cygnus_gpio_probe);
> +}
> +arch_initcall_sync(cygnus_gpio_init);

arch_initcall_sync() is a bit brutal.

Can you please investigate if you can have this as a normal device_initcall()
utilizing deferred probe if necessary?

Follow-up patches accepted!

Yours,
Linus Walleij
