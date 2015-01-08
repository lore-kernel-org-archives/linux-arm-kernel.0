From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Jan 2015 20:37:23 +0100
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <1419967718-26909-4-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdYEHwXhw3nEPHp7+4rtzXyh9Qb2QCpsRMfopxNoaX3rLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Disable the Versatile PCI DT node when no PCI backplane is detected. This
> will prevent the Versatile PCI driver from probing when PCI is not
> populated.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>

(...)
> +       /* Check if PCI backplane is detected */
> +       val = __raw_readl(base + VERSATILE_SYS_PCICTL_OFFSET);

I think this kind of random syscon register access should be handled
using the mfd/syscon.c hub and looked up in some way to be used
by the driver.

I'm thinking along the pattern of adding code in drivers/*
by the pattern of e.g.
drivers/video/fbdev/amba-clcd-versatile.c
i.e. an add-on that gets compiled-in only for those platform
but still married to the main driver.

Yours,
Linus Walleij
