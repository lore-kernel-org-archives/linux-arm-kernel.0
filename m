From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jan 2014 14:39:07 +0100
Subject: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
In-Reply-To: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZNe0L+yZnqrY51Oeg+k5NHXebJAiqxi+p5Scy-BQ2+1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 10:25 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This passes the errata fix using a GPIO to control the RTS pin
> on one of the AT91 chips to use gpiolib instead of the
> AT91-specific interfaces. Also remove the reliance on
> compile-time #defines and the cpu_* check and rely on the
> platform passing down the proper GPIO pin through platform
> data.
>
> This is a prerequisite for getting rid of the local GPIO
> implementation in the AT91 platform and move toward
> multiplatform.
>
> The patch also adds device tree support for getting the
> RTS GPIO pin from the device tree on DT boot paths.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:

ARM SoC folks, if you're not taking this in through the <timex.h> removal
series then please ACK this patch so I can take it through the GPIO
tree instead (unless you want to apply this single patch, which would
be even better, you have Greg's ACK in this thread).

Yours,
Linus Walleij
