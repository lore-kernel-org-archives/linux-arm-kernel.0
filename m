From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Sep 2013 14:49:38 +0100
Subject: [PATCH 42/51] DMA-API: usb: musb: use
 platform_device_register_full() to avoid directly messing with dma
 masks
In-Reply-To: <20130920131125.GO26101@radagast>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnQk-0007sX-Ty@rmk-PC.arm.linux.org.uk> <20130920131125.GO26101@radagast>
Message-ID: <20130920134938.GO25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 08:11:25AM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Sep 20, 2013 at 12:14:38AM +0100, Russell King wrote:
> > Use platform_device_register_full() for those drivers which can, to
> > avoid messing directly with DMA masks.  This can only be done when
> > the driver does not need to access the allocated musb platform device
> > from within its callbacks, which may be called during the musb
> > device probing.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> you want me to carry this one through my tree or you prefer getting my
> Acked-by ? Either way works for me:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> there's also the third option of me setting up a branch with only this
> patch and we both merge it, that'd also work.

I think this patch is sufficiently stand-alone that it should be fine
if you want to take it through your tree.  That may be better in the
long run to avoid conflicts with this patch and any future work in
this area during this cycle.

Thanks.
