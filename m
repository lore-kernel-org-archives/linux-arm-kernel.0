From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 15:11:28 +0100
Subject: [PATCH 2/2] gpio: devm_gpio_* support should not depend on GPIOLIB
In-Reply-To: <1358239056-703-3-git-send-email-shawn.guo@linaro.org>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
 <1358239056-703-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdYChO_YxXj=QcN6nDQebxuHGTZnX29P=t7F=X72Er=onw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 9:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Some architectures (e.g. blackfin) provide gpio API without requiring
> GPIOLIB support (ARCH_WANT_OPTIONAL_GPIOLIB).  devm_gpio_* functions
> should also work for these architectures, since they do not really
> depend on GPIOLIB.
>
> Add a new option GPIO_DEVRES (enabled by default) to control the build
> of devres.c, and move devm_gpio_* function declarations out from #ifdef
> CONFIG_GPIOLIB in include/asm-generic/gpio.h, so that they can be
> available to client drivers without unnecessary dependency on GPIOLIB.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied, thanks!

Yours,
Linus Walleij
