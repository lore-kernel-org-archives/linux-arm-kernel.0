From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 19:18:01 +0200
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> For all ux500 based platforms the maximum number of end-points are used.
> Move this knowledge into the driver so we can relinquish the burden from
> platform data. This also removes quite a bit of complexity from the driver
> and will aid us when we come to enable the driver for Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I guess this stuff is dependent on the stuff Fabio has recently sent to
Felipe for the ux500 musb DMA so these musb patches should
primarily go through his tree.

It seems like the later changes to the platform code
(arch/arm/mach-ux500) may be sufficiently orthogonal
so it can be done out-of-order?

I can't merge any of this without Felipes ACKs in any
case.

Yours,
Linus Walleij
