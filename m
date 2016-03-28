From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 28 Mar 2016 05:27:01 +0000
Subject: [PATCH v2 5/6] Documentation: DT: vdma: update binding doc for
 AXI CDMA
In-Reply-To: <20160327192742.GJ19212@xsjsorenbubuntu>
References: <1459101966-9932-1-git-send-email-appanad@xilinx.com>
 <1459101966-9932-2-git-send-email-appanad@xilinx.com>
 <20160327192742.GJ19212@xsjsorenbubuntu>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A570609@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Monday, March 28, 2016 12:58 AM
> To: Appana Durga Kedareswara Rao
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek;
> vinod.koul at intel.com; dan.j.williams at intel.com; Anurag Kumar Vulisha; Appana
> Durga Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Srikanth
> Vemula; Anirudha Sarangi; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> dmaengine at vger.kernel.org
> Subject: Re: [PATCH v2 5/6] Documentation: DT: vdma: update binding doc for
> AXI CDMA
> 
> On Sun, 2016-03-27 at 23:36:06 +0530, Kedareswara rao Appana wrote:
> > This patch updates the device-tree binding doc for adding support for
> > AXI CDMA.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > ---> Modified commit message as suggested by Vinod.
> > ---> Moved the patch to forward in the series as suggested by vinod.
> >
> >  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt     | 18
> +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index 5841421..2b0c12b 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > @@ -8,8 +8,12 @@ target devices. It can be configured to have one channel
> or two channels.
> >  If configured as two channels, one is to transmit to the device and
> > another  is to receive from the device.
> >
> > +Xilinx AXI CDMA engine, it does transfers between memory-mapped
> > +source address and a memory-mapped destination address.
> > +
> >  Required properties:
> > -- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a"
> > +- compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a" or
> > +	      "xlnx,axi-cdma-1.00.a""
> >  - #dma-cells: Should be <1>, see "dmas" property below
> >  - reg: Should contain VDMA registers location and length.
> >  - xlnx,num-fstores: Should be the number of framebuffers as configured in
> h/w.
> > @@ -80,6 +84,18 @@ axi_dma_0: axidma at 40400000 {
> >  	} ;
> >  } ;
> >
> > +axi_cdma_0: axicdma at 7e200000 {
> > +       compatible = "xlnx,axi-cdma-1.00.a";
> > +       #dma-cells = <1>;
> > +       reg = < 0x7e200000 0x10000 >;
> > +       xlnx,addrwidth = <0x20>;
> > +       dma-channel at 7e200000 {
> > +               compatible = "xlnx,axi-dma-mm2s-channel";
> > +               interrupts = < 0 55 4 >;
> > +               xlnx,datawidth = <0x40>;
> > +       } ;
> > +} ;
> 
> As in the other patch, the node name should be 'dma-controller at ...' and the
> inconsistend spacing could be fixed.

Ok will fix...

> 
> Also, it seems this adds pretty much identical examples that just differ in the
> compat string. Is that really needed?

Most of the properties are same across the three DMA's
For AXI VDMA there are few required properties that are not required for AXI DMA/CDMA.
That's why added example for the other IP's as well I mean for AXI DMA and CDMA.

Regards,
Kedar.

> 
> 	S?ren
