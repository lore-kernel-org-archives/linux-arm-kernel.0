From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 18 Jun 2013 10:53:16 +0200
Subject: [PATCH] ARM: ux500: set coherent_dma_mask for dma40
In-Reply-To: <CACRpkdYOP0xTJo3sLbRz5D=b4Vb1484a1qfE3aVAKRTM4+Y7QQ@mail.gmail.com>
References: <1371131763-6288-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdYOP0xTJo3sLbRz5D=b4Vb1484a1qfE3aVAKRTM4+Y7QQ@mail.gmail.com>
Message-ID: <20130618085316.GA7239@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 05:42:48PM +0200, Linus Walleij wrote:
> On Thu, Jun 13, 2013 at 3:56 PM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
> 
> > Set coherent_dma_mask to DMA_BIT_MASK(32) for dma40 platform_device, as
> > without this DMA allocations were failing with the error:
> >
> > dma40 dma40.0: coherent DMA mask is unset
> >
> > when booting without device-tree.
> >
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > ---
> >
> > Hi Linus, Lee,
> >
> > I found this while removing the last hack I was keeping in my ASoC tree.
> > I originally thought that I had to set this on the driver's pdata, but
> > it turns out it's needed on the DMA controller one instead.
> >
> > When booting with device-tree enabled the mask seems to be set
> > automatically.
> >
> > Would you consider applying this with the other dma40 patches?
> 
> Those are now upstream in the ARM SoC tree, you'd have to send it
> to arm at kernel.org and ask Olof/Arnd to apply it directly to
> the next/drivers branch (I think).

Ok I can resend it but I'd like to have Lee's Ack before doing that.

Lee: have you had a chance to look at this patch?

> I have also queued it on ux500-fixes so it won't be lost.

That's nice!

Thanks,
Fabio

-- 
Fabio Baltieri
