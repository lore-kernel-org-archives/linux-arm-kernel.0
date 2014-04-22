From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 13:54:52 +0200
Subject: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by
 bootloader
In-Reply-To: <1397173639-29587-12-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-12-git-send-email-tony@atomide.com>
Message-ID: <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:

> Since we set up device wake-up interrupts as pinctrl-single
> interrupts, we now must use the standard request_irq and
> related functions to manage them.
>
> If the pin interrupts are enabled for some pins at boot,
> the wake-up events can show up as constantly pending
> at least on omaps and will hang the system unless the related
> device driver clears the event at the device.
>
> To fix this, let's clear the interrupt flags during init,
> and print out a warning so the board maintainers can update
> their drivers to do proper request_irq for the driver specific
> wake-up events.
>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks clean.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Shall I apply this patch or will you funnel it through ARM SoC
due to deps?

Yours,
Linus Walleij
