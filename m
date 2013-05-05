From: bp@alien8.de (Borislav Petkov)
Date: Sun, 5 May 2013 22:39:32 +0200
Subject: [PATCH v4 0/7] enable support for AMBA drivers under x86
In-Reply-To: <20130505202422.GA13758@mail.gnudd.com>
References: <20130505123633.GA14095@pd.tnic> <50C93A83.8040106@zytor.com>
 <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <50C93718.2090706@zytor.com>
 <20121213181449.GA15966@mail.gnudd.com>
 <20130505202422.GA13758@mail.gnudd.com>
Message-ID: <20130505203932.GA12742@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 05, 2013 at 10:24:22PM +0200, Alessandro Rubini wrote:
> > Did this got fixed in some tree in the meantime? Because I still see it on
> > current Linus + tip/master:
> > 
> > arch/x86/pci/sta2x11-fixup.c:186:2: warning: initialization from incompatible pointer type [enabled by default]
> > arch/x86/pci/sta2x11-fixup.c:186:2: warning: (near initialization for ???sta2x11_dma_ops.free???) [enabled by default]
> 
> Last time I sent the patch was on Feb 22nd:
> 
>    The .free field of struct dma_map_ops features a prototype that is
>    different from what lib/swiotlb.c offers. The new "attrs" argument in
>    dma_ops.free is missing from the generic implementation.
> 
>    This removes the build warning by providing a function that just calls
>    swiotlb_free_coherent() without passing "attrs", like others do.
> 
> I got no reply.

It probably fell through the cracks...

> This is the link:
> 
>     http://lkml.org/lkml/2013/2/22/111
> 
> It is in patchwork here:
> 
>     https://patchwork.kernel.org/patch/2175551/

Ingo, hpa, can you guys pick it up?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
