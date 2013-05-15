From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Wed, 15 May 2013 22:14:39 +0200
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
Message-ID: <20130515201439.GA10141@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Wed, May 15, 2013 at 07:18:01PM +0200, Linus Walleij wrote:
> On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > For all ux500 based platforms the maximum number of end-points are used.
> > Move this knowledge into the driver so we can relinquish the burden from
> > platform data. This also removes quite a bit of complexity from the driver
> > and will aid us when we come to enable the driver for Device Tree.
> >
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: linux-usb at vger.kernel.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I guess this stuff is dependent on the stuff Fabio has recently sent to
> Felipe for the ux500 musb DMA so these musb patches should
> primarily go through his tree.

Not really, I only sent some coding style fix for the dma driver, as
almost all of my work was in the usb phy files.  I also checked my
latest series against Lee's tree and the two seems to merge without any
conflict, so as far as I'm concerned it's really up to you and Felipe.

Fabio

> It seems like the later changes to the platform code
> (arch/arm/mach-ux500) may be sufficiently orthogonal
> so it can be done out-of-order?
> 
> I can't merge any of this without Felipes ACKs in any
> case.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Fabio Baltieri
