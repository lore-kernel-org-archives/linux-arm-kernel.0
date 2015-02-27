From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:24:44 +0100
Subject: [PATCH 04/10] ARM: no longer force unbuffered DMA for realview
In-Reply-To: <1424967068-261464-1-git-send-email-arnd@arndb.de>
References: <1424967068-261464-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZ8fR5p7PvtQhkQWFwyVK-K86R-SBU9YWr0zG0VN7ruow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Commit 42c4dafe803dca ("ARM: 6202/1: Do not ARM_DMA_MEM_BUFFERABLE
> on RealView boards with L210/L220") changed the generic setting for
> ARM_DMA_MEM_BUFFERABLE to be disabled on any Realview kernel that includes
> support for any of the ARM11 variations. Doing this was required to
> allow doing DMA without a lockup in the l2x0 cache controller on the
> Realview platform.
>
> Unfortunately, in a kernel that also contains support for any ARMv7
> based machine, the same change makes it impossible to do DMA on ARMv7,
> which gets in the way of enabling multiplatform support on Realview.
>
> As confirmed by Catalin Marinas and Linus Walleij, the current
> code for Realview that we have in the kernel does not actually
> perform any DMA, and this is unlikely to change in the future.
> Therefore we can revert 42c4dafe803dca without introducing regressions,
> but we must never start using DMA on this platform in the future.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>

The only platform that I actually got it working on was ARM PB11MPCore,
and only for the PL011 serial port (MMC for example will never work).
Maybe AACI works, maybe. But it's not worth the effort, so:

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
