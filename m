From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 17 Apr 2018 10:54:57 +0000
Subject: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
 has_axieth_connected
In-Reply-To: <20180411090525.GX6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-2-git-send-email-radheys@xilinx.com>
 <20180411090525.GX6014@localhost>
Message-ID: <MWHPR02MB3293878F33D165B799DB8A96C7B70@MWHPR02MB3293.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Wednesday, April 11, 2018 2:35 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; Rob Herring
> <robh@kernel.org>; devicetree at vger.kernel.org
> Cc: dan.j.williams at intel.com; michal.simek at xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars at metafoo.de; dmaengine at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
> has_axieth_connected
> 
> On Mon, Apr 02, 2018 at 04:09:01PM +0530, Radhey Shyam Pandey wrote:
> > Add an optional AXI DMA property 'has_axieth_connected'. This can be
> > specified to indicate that AXI DMA is connected to AXI Ethernet in
> > hardware design and dma driver needs to do some additional handling.
> 
> 1. why are DT people and list not added to this? I have added that
Sorry missed it. I will add in v2. Thanks.
> 2. should we have a property for a specific peripheral? Wouldn't it help to
> have
> a generic property for peripheral connected which can be scaled to more IPs
> being connected in future?
Good point! I will rename this property to xlnx,axistream-connected and
update description. It can then be reused for other usecases as well.
> 3. Please use right subsystem name, it damengine: not dma:
I will fix.
> 
> >
> > Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> > ---
> >  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > index a2b8bfa..5d592e3 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > @@ -42,6 +42,7 @@ Optional properties:
> >  	the hardware.
> >  Optional properties for AXI DMA:
> >  - xlnx,mcdma: Tells whether configured for multi-channel mode in the
> hardware.
> > +- xlnx,axieth-connected: Tells whether AXI DMA is connected to AXI
> Ethernet.
> >  Optional properties for VDMA:
> >  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> >  	It takes following values:
> > --
> > 1.7.1
> >
> 
> --
> ~Vinod
