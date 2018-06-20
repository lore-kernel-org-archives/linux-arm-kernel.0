From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 20 Jun 2018 14:37:00 +0000
Subject: [PATCH 3/6] dt-bindings: xilinx_dma: add required
 xlnx,lengthregwidth property
In-Reply-To: <DM6PR02MB43610E55E255E9DA5B9E4630C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-3-andrea.merello@gmail.com>
 <DM6PR02MB43610E55E255E9DA5B9E4630C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
Message-ID: <DM6PR02MB43617C120779E4BF0CF9FBEAC7770@DM6PR02MB4361.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Radhey Shyam Pandey
> Sent: Wednesday, June 20, 2018 7:13 PM
> To: Andrea Merello <andrea.merello@gmail.com>; vkoul at kernel.org;
> dan.j.williams at intel.com; Michal Simek <michals@xilinx.com>; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; dmaengine at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: RE: [PATCH 3/6] dt-bindings: xilinx_dma: add required
> xlnx,lengthregwidth property
> 
> 
> > -----Original Message-----
> > From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> > owner at vger.kernel.org] On Behalf Of Andrea Merello
> > Sent: Wednesday, June 20, 2018 2:07 PM
> > To: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
> > <michals@xilinx.com>; Appana Durga Kedareswara Rao
> > <appanad@xilinx.com>; dmaengine at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > Andrea Merello <andrea.merello@gmail.com>
> > Subject: [PATCH 3/6] dt-bindings: xilinx_dma: add required
> > xlnx,lengthregwidth property
> 
> dt-bindings: dmaengine: xilinx_dma
> 
> Please also include DT folks.
> >
> > The width of the "length register" cannot be autodetected, and it is now
> > specified with a DT property. Add DOC for it.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > index a2b8bfaec43c..acecdc5d8d47 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > @@ -36,6 +36,8 @@ Required properties:
> >
> >  Required properties for VDMA:
> >  - xlnx,num-fstores: Should be the number of framebuffers as configured in
> > h/w.
> > +Required properties for AXI DMA:
> > +- xlnx,lengthregwidth: Should be the width of the length register as
> > configured in h/w.
> 
> One suggestion to be inline with IP property naming we can rename
> this prop to "xlnx,sg-length-width"? Please take a look at Xilinx tree
> we have this feature added in the master branch. It would be good
> to consolidate both implementations and upstream. Let me know
> if there are any followup queries.

It should be ok to cherrypick 3/6 and 4/6 (xlnx,sg-length-width)
from Xilinx tree and include it in your v2 patch series. 

> 
> >
> >  Optional properties:
> >  - xlnx,include-sg: Tells configured for Scatter-mode in
> > --
> > 2.17.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
