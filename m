From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 15:49:57 +0200
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <51C97F40.5030101@arm.com>
References: <51C97F40.5030101@arm.com>
Message-ID: <CACRpkdb-Fhz3pjWm3xVguitv6h0-+ywyo3HFDVgqgHcZ-MjKKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 1:30 PM, Jonathan Austin
<jonathan.austin@arm.com> wrote:

> There's a patch making its way to mainline via Russell's tree
> (8d96250700: ARM: mm: Transparent huge page support for LPAE systems)
> that breaks the build of the amba-pl08x driver (drivers/dma/amba-pl08x.c)
> because the 'get_signal' macro from include/linux/signal.h is now in the
> driver's scope and it clobbers a (previously) valid function call.

This is already fixed by Mark Brown in the DMA tree.

Commit subject:
"dmaengine: PL08x: Avoid collisions with get_signal() macro"

Yours,
Linus Walleij
