From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 May 2014 11:46:41 +0200
Subject: [PATCH v2 03/11] irqchip: versatile-fpga: add support for arm,
 versatile-sic
In-Reply-To: <1401403221-27523-4-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
 <1401403221-27523-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdaUfN+mwiwca0fdXgGT+bGhE_-Vuaw0xxdTeBMRMX7_5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:40 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> The secondary controller on ARM Versatile AB and PB is similar to
> other ARM platforms, but has a pass-thru register to connect some
> interrupts directly to interrupt inputs on the primary interrupt
> controller. The PIC_ENABLES register needs to be configured for
> proper operation when the matching node is arm,versatile-sic. Add the
> the necessary IRQCHIP_DECLARE as well.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> v2:
> - Rework to use the compatible string for pass-thru register setup.

Nice!

> +       /*
> +        * On Versatile AB/PB, some secondary interrupts have a direct
> +        * pass-thru to the primary controller which need to be enabled.
> +        */
> +       if (of_device_is_compatible(node, "arm,versatile-sic"))
> +               writel(0xffd00000, base + PIC_ENABLES);

Maybe mention that we pass thru IRQs 20 and 22 thru 31 and
why exactly these IRQs?

Anyway:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
