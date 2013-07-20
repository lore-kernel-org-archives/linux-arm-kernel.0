From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Jul 2013 22:45:29 +0200
Subject: [PATCH v9] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1374048297-4321-1-git-send-email-jonas.jensen@gmail.com>
References: <1373985880-23469-1-git-send-email-jonas.jensen@gmail.com>
 <1374048297-4321-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACRpkdYktthfRsn9=9GjphXUbOEAswdCZCM48KFK2WRgBdj-Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:04 AM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/io.h>
> +#include <linux/clocksource.h>

#include <linux/bitops.h>

> +#define TIMEREG_CR_1_ENABLE    BIT(0)

Because BIT() comes from there. And we shall not rely on
implicit #inclusion.

Apart from that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
