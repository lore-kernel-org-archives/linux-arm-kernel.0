From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Aug 2013 10:03:17 +0200
Subject: [PATCH v6 1/2] gpio: bcm281xx: Add GPIO driver
In-Reply-To: <1377820267-20050-2-git-send-email-markus.mayer@linaro.org>
References: <1377820267-20050-1-git-send-email-markus.mayer@linaro.org>
 <1377820267-20050-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdY-feNrJvL6_pbPtQ0Z1Q8ukaszqPMY4EPKhbuNgw0A1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 1:51 AM, Markus Mayer <markus.mayer@linaro.org> wrote:

> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index f112895..5819126 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -9,7 +9,7 @@ config ARCH_BCM
>         select CLKSRC_OF
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_TIME
> -       select GPIO_BCM
> +       select GPIO_BCM_KONA
>         select SPARSE_IRQ
>         select TICK_ONESHOT
>         help

No. I didn't ask you to move this hunk over to this patch.

Just the two hunks hitting:

- Kconfig
- Makefile

Further I only wanted *this* patch [1/3] to be renamed with
the gpio: prefix, not the other two.

The idea is:

Patch mainly touches drivers/gpio/* -> gpio: prefix
Patch mainly touches arch/arm/* -> ARM: prefix

Yours,
Linus Walleij
