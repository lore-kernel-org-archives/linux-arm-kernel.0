From: balbi@ti.com (Felipe Balbi)
Date: Fri, 1 Feb 2013 22:56:00 +0200
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <510C2A47.1090607@mvista.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi>
 <510C2A47.1090607@mvista.com>
Message-ID: <20130201205600.GA31762@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Fri, Feb 01, 2013 at 11:49:11PM +0300, Sergei Shtylyov wrote:
> > good point, do you wanna send some patches ?
> 
>    I have already sent them countless times and even stuck CPPI 4.1 support (in
> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remove the
> patch. :-(

sticking into arch/arm/common/ wasn't a nice move. But then again, so
wasn't asking for the patch to be removed :-s

> > I guess to make the MUSB side simpler we would need musb-dma-engine glue
> > to map dmaengine to the private MUSB API. Then we would have some
> > starting point to also move inventra (and anybody else) to dmaengine
> > API.
> 
>    Why? Inventra is a dedicated device's private DMA controller, why make
> universal DMA driver for it?

because it doesn't make sense to support multiple DMA APIs. We can check
from MUSB's registers if it was configured with Inventra DMA support and
based on that we can register MUSB's own DMA Engine to dmaengine API.

> > Once that's done, we drop MUSB's private API.
> 
>    Don't think it's a good idea.

see above.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130201/859fc0e0/attachment.sig>
