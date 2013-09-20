From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 20:28:16 +0200
Subject: [PATCH v9 1/3] gpio: bcm281xx: Add GPIO driver
In-Reply-To: <1378836423-12467-2-git-send-email-markus.mayer@linaro.org>
References: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
 <1378836423-12467-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdZocV3M5OUtg6BWGPF+vrtavk0kWB2FZoFCtkEJbupq7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 8:07 PM, Markus Mayer <markus.mayer@linaro.org> wrote:

> From: Markus Mayer <mmayer@broadcom.com>
>
> Add the GPIO driver for the Broadcom bcm281xx family of mobile SoCs.
> These GPIO controllers may contain up to 8 banks where each bank
> includes 32 pins that can be driven high or low and act as an edge
> sensitive interrupt.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

It's a fine driver and I applied it. Any remaining issues to be fixed with
follow-up patches.

I changed one thing:

> +config GPIO_BCM_KONA
> +       bool "Broadcom Kona GPIO"

I added
depends on OF_GPIO

here.

Otherwise I don't think it will compile on randconfigs.

Yours,
Linus Walleij
