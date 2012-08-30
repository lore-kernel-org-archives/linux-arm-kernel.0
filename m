From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 15:17:39 -0700
Subject: [PATCH 02/10] gpio: pxa: add explicit includes for cpu_is_X macros
In-Reply-To: <1346279496-26286-3-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-3-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdasWv8toA1eBzpYo4QactNhkpzhuBk-D8kJbbM03WZN2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 3:31 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> In preparation to remove implicit inclusion of mach/gpio.h, add the
> necessary includes for cpu_is_X macros.

The commit message talks about gpio.h, but...

>  #include <mach/irqs.h>
> +#include <mach/hardware.h>
> +#ifdef CONFIG_ARCH_MMP
> +#include <mach/cputype.h>
> +#endif

This seems completely unrelated, but correct in the sense that every driver
should include its resources.

But isn't the proper fix to move arch/arm/mach-pxa/include/mach/cputype.h to
include/linux/*/pxa-cputype.h or something (note: no clue what "*" should be!),
or even better, modify this one driver to take a flag from platform data and/or
DT?

Anyway, we need the PXA maintainers to look at this.

Yours,
Linus Walleij
