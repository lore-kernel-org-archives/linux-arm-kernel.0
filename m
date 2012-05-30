From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:52:53 +0800
Subject: [RFC 03/34] dmaengine: virt-dma: add support for cyclic DMA
 periodic callbacks
In-Reply-To: <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdba_aFbyBt9hkYqBR=oY6fq0KHchjGcuS_NhbOMbE0Owg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:36 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add support for cyclic DMA's periodic callbacks. ?Drivers are expected
> to call vchan_cyclic_callback() when a period has completed, which will
> schedule the tasklet to make the callback into the driver.
>
> As callbacks are made from tasklet context, it is important to realise
> that we don't guarantee a callback for each completed period, but for
> N completed periods where N may be greater than one.

This last thing was something we have to fix right?
Like for each driver to keep a counter of completed periods
and call the handler repeatedly if N > 1.

Anyway this doesn't make the problem worse in any way so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
