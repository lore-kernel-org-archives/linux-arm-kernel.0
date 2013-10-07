From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Oct 2013 17:28:37 +0200 (CEST)
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <20131007142511.GJ2954@intel.com>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
 <Pine.LNX.4.64.1310071409080.20796@axis700.grange>
 <20131007142511.GJ2954@intel.com>
Message-ID: <Pine.LNX.4.64.1310071725300.20796@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Vinod Koul wrote:

> On Mon, Oct 07, 2013 at 02:15:22PM +0200, Guennadi Liakhovetski wrote:
> > On Mon, 7 Oct 2013, Vinod Koul wrote:
> > 
> > > On Mon, Oct 07, 2013 at 12:17:28PM +0100, Russell King - ARM Linux wrote:
> > > > On Mon, Oct 07, 2013 at 12:45:33PM +0200, Guennadi Liakhovetski wrote:
> > > > > No, not something in the middle. I was thinking about
> > > > > 
> > > > > (1) cookie 1-3 are submitted
> > > > > (2) cookie 1 succeeds
> > > > > (3) a DMA error occurs, cookies 2-3 are discarded
> > > discarded using terminate_all right?
> > 
> > No, by the dmaengine driver as a part of the error processing.
> And how will that be done...?

Sorry, I meant - DMA descriptors with cookies #2 and #3 will be cancelled 
and recycled by the dmaengine driver. That's what you have to do, when 
processing DMA error IRQ.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
