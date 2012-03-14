From: chanho0207@gmail.com (Chanho Min)
Date: Wed, 14 Mar 2012 10:47:37 +0900
Subject: [PATCH v3] serial: PL011: clear pending interrupts
In-Reply-To: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOAMb1AKmsNQbmVAaYq5G8cdafCVpRyA=5xgocqYfLsQ6BLXMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 9:27 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Chanho Min reported that when the boot loader transfers
> control to the kernel, there may be pending interrupts
> causing the UART to lock up in an eternal loop trying to
> pick tokens from the FIFO (since the RX interrupt flag
> indicates there are tokens) while in practice there are
> no tokens - in fact there is only a pending IRQ flag.
>
> This patch address the issue with a combination of two
> patches suggested by Russell King that clears and mask
> all interrupts at probe() and clears any pending error
> and RX interrupts at port startup time.
>
> We suspect the spurious interrupts are a side-effect of
> switching the UART from FIFO to non-FIFO mode.
I've tested this patch, and have confirmed that the issue is resolved
on our CA9 platform.
In addition, May I ask to change the tag as follows.

Reported-by: Chanho Min <chanho.min@lge.com>
Reviewed-by: Jong-Sung Kim <neidhard.kim@lge.com>

Thanks a lot !
Chanho Min
