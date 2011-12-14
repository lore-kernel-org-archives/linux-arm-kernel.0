From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 18:40:51 +0100
Subject: [RFC PATCH v2 0/4] pinctrl: imx: add pinnmux support
In-Reply-To: <1323878622-26602-1-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdbNOLBxsbAnnYSNiPaQ3EAj6eQ9=C8jJDb+jKP3GdjRcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 5:03 PM, Dong Aisheng <b29396@freescale.com> wrote:

> For DT support, there's still one issue that for pinmux_map,
> since it's board specific, i wonder if it can be parsed by pinctrl
> subsystem via dt rather than by each driver.

That is definately how it should be done. Seems like a good
idea to me.

> but pinctrl still does not supported that, i still only called
> it in mach-imx6q.c which seems not a correct place.

Don't worry that pinctrl does not support it - patch pinctrl core!

Just make a separate patch which patches drivers/pinctrl/pinmux.c
to ass the device tree parsing you need from the core, and we'll
review it.

I am by far too incompetent in device tree mechanisms to do
that myself, I have never worked much on device tree.

Thanks,
Linus Walleij
