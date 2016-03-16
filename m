From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 16 Mar 2016 06:19:17 +0000
Subject: [PATCH 4/7] dmaengine: xilinx_vdma: Add Support for Xilinx AXI
 Direct Memory Access Engine
In-Reply-To: <20160316031721.GO13211@localhost>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-5-git-send-email-appanad@xilinx.com>
 <20160316031721.GO13211@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A56D300@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Wednesday, March 16, 2016 8:47 AM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi; dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 4/7] dmaengine: xilinx_vdma: Add Support for Xilinx AXI
> Direct Memory Access Engine
> 
> On Tue, Mar 15, 2016 at 10:53:09PM +0530, Kedareswara rao Appana wrote:
> > This patch updates the device-tree binding doc for adding support for
> > AXI DMA.
> 
> Binding patch should precced the driver. and the title doesn't tell me its a binding
> patch and might get ignore by folks.

Sure will fix in the next version of the patch series.

> 
> Pls cc device tree ML on these patches. And please read
> Documentation/devicetree/bindings/submitting-patches.txt. Its there for a
> purpose

Sure will cc device-tree people in the next version of the patch series for the device-tree binding doc patches.

Thanks,
Kedar.

> 
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> >  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 22
> > +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index e4c4d47..3d134a5 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > @@ -3,8 +3,13 @@ It can be configured to have one channel or two
> > channels. If configured  as two channels, one is to transmit to the
> > video device and another is  to receive from the video device.
> >
> > +Xilinx AXI DMA engine, it does transfers between memory and AXI4
> > +stream target devices. It can be configured to have one channel or two
> channels.
> > +If configured as two channels, one is to transmit to the device and
> > +another is to receive from the device.
> > +
> >  Required properties:
> > -- compatible: Should be "xlnx,axi-vdma-1.00.a"
> > +- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a"
> >  - #dma-cells: Should be <1>, see "dmas" property below
> >  - reg: Should contain VDMA registers location and length.
> >  - xlnx,num-fstores: Should be the number of framebuffers as configured in
> h/w.
> > @@ -55,6 +60,21 @@ axi_vdma_0: axivdma at 40030000 {
> >  	} ;
> >  } ;
> >
> > +axi_dma_0: axidma at 40400000 {
> > +	compatible = "xlnx,axi-dma-1.00.a";
> > +	#dma_cells = <1>;
> > +	reg = < 0x40400000 0x10000 >;
> > +	dma-channel at 40400000 {
> > +		compatible = "xlnx,axi-vdma-mm2s-channel";
> > +		interrupts = < 0 59 4 >;
> > +		xlnx,datawidth = <0x40>;
> > +	} ;
> > +	dma-channel at 40400030 {
> > +		compatible = "xlnx,axi-vdma-s2mm-channel";
> > +		interrupts = < 0 58 4 >;
> > +		xlnx,datawidth = <0x40>;
> > +	} ;
> > +} ;
> >
> >  * DMA client
> >
> > --
> > 2.1.2
> >
> 
> --
> ~Vinod
