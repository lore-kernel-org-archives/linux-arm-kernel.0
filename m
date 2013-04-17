From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Apr 2013 17:20:48 +0200
Subject: [PATCH v4] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <201304140138.40142.heiko@sntech.de>
References: <201304140138.40142.heiko@sntech.de>
Message-ID: <CACRpkdYaKpDtWM5N1NNnWch5m+KYB-2HQgNNddTYiiF1pQ4S_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 1:38 AM, Heiko St?bner <heiko@sntech.de> wrote:

> The s3c24xx pins follow a similar pattern as the other Samsung SoCs and
> can therefore reuse the already introduced infrastructure.
>
> The s3c24xx SoCs have one design oddity in that the first 4 external
> interrupts do not reside in the eint pending register but in the main
> interrupt controller instead. We solve this by forwarding the external
> interrupt from the main controller into the irq domain of the pin bank.
> The masking/acking of these interrupts is handled in the same way.
>
> Furthermore the S3C2412/2413 SoCs contain another oddity in that they
> keep the same 4 eints in the main interrupt controller and eintpend
> register and requiring ack operations to happen in both. This is solved
> by using different compatible properties for the wakeup eint node which
> set a property accordingly.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Looking good, Acked-by: Linus Walleij <linus.walleij@linaro.org>

I prefer this:

#include <linux/bitops.h>

int foo = BIT(7);

over

int foo = (1 << 7);

But no big deal.

Are you taking this through the Samsung tree?

Yours,
Linus Walleij
