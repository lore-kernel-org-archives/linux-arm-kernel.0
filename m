From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 9 Dec 2014 14:11:29 +0800
Subject: [PATCH] irqchip: mediatek: Fix error return code detection
In-Reply-To: <alpine.DEB.2.11.1412082114340.16275@nanos>
References: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
 <alpine.DEB.2.11.1412082114340.16275@nanos>
Message-ID: <1418105489.32622.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-12-08 at 21:30 +0100, Thomas Gleixner wrote:
> On Mon, 8 Dec 2014, Yingjoe Chen wrote:
> 
> > This fix an error handling bug reported by Beniamino, this is based on
> > mtk intpol patches [1]
> >
> > Joe.C
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305808.html
> > 
> > ====================
> > of_io_request_and_map() return ERR_PTR wrapped error code instead of
> > NULL when fail, fix code in mtk_sysirq_of_init() to correctly handle
> > this.
> > 
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> This is not a proper changelog. Let me write up a proper one:
> 
> Subject: irqchip: mediatek: Use IS_ERR() instead of NULL pointer check
> 
> Beniamino reported a kernel oops caused by an invalid DT file for the
> mediatek interrupt polarity extension.
> 
> The reason is that the interrupt polarity support for mediatek chips
> merily checks for at NULL pointer instead of a casted error return
> value in mtk_sysirq_of_init() so any other casted error value passes
> the NULL pointer check and causes a kernel panic when dereferenced.
> 
> Use IS_ERR() and return the error value via PTR_ERR().
> 
> Reported-and-tested-by: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> Can you see the difference?
> 
> Thanks,
> 
> 	tglx

Thanks for the review.

This changelog describe issue and why we need this change more clearly.
I'll prepare a new patch with this changelog, Thanks.

Joe.C
