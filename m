From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:50:47 +0200
Subject: [PATCH 05/39] ARM: ux500: Stop passing MMC's platform data for
 Device Tree boots
In-Reply-To: <1368611522-9984-6-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbOxzhgR=ugXLrSBJ_Y1rw=0mcrvtuRi=-c5v039xsPWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> It was required to pass DMA channel configuration information to the
> MMC driver before the new DMA API was in place. Now that it is, and
> is fully compatible with Device Tree we can stop doing that.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

So since the use of dma_request_slave_channel() is not upstream,
I guess this will break DMA use (i.e slow down transfers!) on all
device tree boots?

I'd be happy to apply it once the MMCI patch is in linux-next
indicating there may just be a window in the merge period
where it falls back to IRQ mode, but I don't want to disable
DMA on DT boots for an entire kernel cycle just like that.

Not applied as of yet.

Yours,
Linus Walleij
