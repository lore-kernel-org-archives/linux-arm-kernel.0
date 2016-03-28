From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 28 Mar 2016 05:27:04 +0000
Subject: [PATCH v2 3/6] Documentation: DT: vdma: update binding doc for
 AXI DMA
In-Reply-To: <20160327192600.GI19212@xsjsorenbubuntu>
References: <1459101966-9932-1-git-send-email-appanad@xilinx.com>
 <20160327192600.GI19212@xsjsorenbubuntu>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A570615@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Monday, March 28, 2016 12:56 AM
> To: Appana Durga Kedareswara Rao
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek;
> vinod.koul at intel.com; dan.j.williams at intel.com; Anurag Kumar Vulisha; Appana
> Durga Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Srikanth
> Vemula; Anirudha Sarangi; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> dmaengine at vger.kernel.org
> Subject: Re: [PATCH v2 3/6] Documentation: DT: vdma: update binding doc for
> AXI DMA
> 
> On Sun, 2016-03-27 at 23:36:05 +0530, Kedareswara rao Appana wrote:
> > This patch updates the device-tree binding doc for adding support for
> > AXI DMA.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v2:
> > ---> Modified commit message as suggested by Vinod.
> > ---> Moved the patch to forward in the series as suggested by vinod.
> >
> >  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 22
> > +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index a86737c..5841421 100644
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
> > @@ -59,6 +64,21 @@ axi_vdma_0: axivdma at 40030000 {
> >  	} ;
> >  } ;
> >
> > +axi_dma_0: axidma at 40400000 {
> 
> The node names should follow the generic names, hence 'dma-controller at ...'.

Ok will fix in next version...

> 
> > +	compatible = "xlnx,axi-dma-1.00.a";
> > +	#dma-cells = <1>;
> > +	reg = < 0x40400000 0x10000 >;
> > +	dma-channel at 40400000 {
> > +		compatible = "xlnx,axi-dma-mm2s-channel";
> > +		interrupts = < 0 59 4 >;
> > +		xlnx,datawidth = <0x40>;
> > +	} ;
> > +	dma-channel at 40400030 {
> > +		compatible = "xlnx,axi-dma-s2mm-channel";
> > +		interrupts = < 0 58 4 >;
> > +		xlnx,datawidth = <0x40>;
> 
> Nit: The spacing around the '<' '>' is inconsistent. I'd just remove all redundant
> spaces.

Ok will fix in next version...

Regards,
Kedar.

> 
> 	S?ren
