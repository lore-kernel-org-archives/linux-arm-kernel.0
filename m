From: balbi@ti.com (Felipe Balbi)
Date: Fri, 1 Feb 2013 20:58:20 +0200
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <510C1D0E.6030401@mvista.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
Message-ID: <20130201185820.GE29898@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 01, 2013 at 10:52:46PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/01/2013 09:49 PM, Matt Porter wrote:
> 
> >>> Move mach-davinci/dma.c to common/edma.c so it can be used
> >>> by OMAP (specifically AM33xx) as well.
> 
> >> I think this should rather go to drivers/dma/?
> 
> > No, this is the private EDMA API. It's the analogous thing to
> > the private OMAP dma API that is in plat-omap/dma.c. The actual
> > dmaengine driver is in drivers/dma/edma.c as a wrapper around
> > this...same way OMAP DMA engine conversion is being done.
> 
>   Keeps me wondering why we couldn't have the same with CPPI 4.1 when I proposed
> that, instead of waiting indefinitely for TI to convert it to drivers/dma/
> directly. We could have working MUSB DMA on OMAP-L1x/Sitara all this time... Sigh.

good point, do you wanna send some patches ?

I guess to make the MUSB side simpler we would need musb-dma-engine glue
to map dmaengine to the private MUSB API. Then we would have some
starting point to also move inventra (and anybody else) to dmaengine
API.

Once that's done, we drop MUSB's private API.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130201/82d77776/attachment.sig>
