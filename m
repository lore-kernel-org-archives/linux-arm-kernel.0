From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 20 Apr 2016 08:39:40 +0000
Subject: [PATCH 1/2] Documentation: DT: vdma: Add clock support for vdma
In-Reply-To: <CAKfKVtEkfnDqU476troXmCw20ATvQvj-JdPX-BCuPDR-9ZxKHQ@mail.gmail.com>
References: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
 <CAKfKVtEkfnDqU476troXmCw20ATvQvj-JdPX-BCuPDR-9ZxKHQ@mail.gmail.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A578F73@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

> -----Original Message-----
> From: Shubhrajyoti Datta [mailto:shubhrajyoti.datta at gmail.com]
> Sent: Wednesday, April 20, 2016 1:30 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>;
> Mark Rutland <mark.rutland@arm.com>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; Michal
> Simek <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> vinod.koul at intel.com; dan.j.williams at intel.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; Moritz Fischer <moritz.fischer@ettus.com>;
> Laurent Pinchart <laurent.pinchart@ideasonboard.com>;
> luis at debethencourt.com; Anirudha Sarangi <anirudh@xilinx.com>; Punnaiah
> Choudary Kalluri <punnaia@xilinx.com>; dmaengine at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] Documentation: DT: vdma: Add clock support for vdma
> 
> On Wed, Apr 20, 2016 at 12:49 PM, Kedareswara rao Appana
> <appana.durga.rao@xilinx.com> wrote:
> > This patch updates the binding doc with clock description for vdma.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 6
> > ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index fcc2b65..e1c9019 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > @@ -21,6 +21,10 @@ Required properties:
> >  - dma-channel child node: Should have at least one channel and can have up
> to
> >         two channels per device. This node specifies the properties of each
> >         DMA channel (see child node properties below).
> > +- clocks: Input clock specifier. Refer to common clock bindings.
> > +- clock-names: List of input clocks "axi_clk", "tx_clk", "txs_clk" (list of input
> > +              cloks may vary based on the ip configuration. see clock bindings
> > +              for more info).
> >
> >  Required properties for VDMA:
> >  - xlnx,num-fstores: Should be the number of framebuffers as configured in
> h/w.
> > @@ -60,6 +64,8 @@ axi_vdma_0: axivdma at 40030000 {
> >         xlnx,num-fstores = <0x8>;
> >         xlnx,flush-fsync = <0x1>;
> >         xlnx,addrwidth = <0x20>;
> > +       clocks = <&clk 0>, <&clk 1>, <&clk 2>;
> > +       clock-names = "axi_clk", "tx_clk", "txs_clk";
> 
> the module has
> s_axi_lite_aclk Clock I AXI VDMA AXI4-Lite interface clock  m_axi_mm2s_aclk
> Clock I AXI VDMA MM2S clock  m_axi_s2mm_aclk Clock I AXI VDMA S2MM clock
> m_axis_mm2s_aclk Clock I AXI VDMA MM2S AXIS clock  s_axis_s2mm_aclk
> Clock I AXI VDMA S2MM AXIS clock
> 
> I think a partial support is not wrong.

It is not partial support the driver is supporting all the clocks available in the IP (please refer the patch 2 in the series).
In the example I just putted clock names for TX path I mean when the IP is configured only with one channel.

Will update the clock-names example with the all the supported clocks in the next version.

> however  we should keep the names same as the TRM.

Why?? Why can't we use simple convenient names that refers to equivalent clocks of h/w 
I mean I used axi_clk instead of s_axi_lite_aclk,
Used tx_clk instead of m_axi_mm2s_aclk,
Used txs_clk instead of m_axis_mm2s_aclk.

If it mandatory to use names as the TRM please let me know will update the same v2...

Regards,
Kedar.

> 
> 
> >         dma-channel at 40030000 {
> >                 compatible = "xlnx,axi-vdma-mm2s-channel";
> >                 interrupts = < 0 54 4 >;
> > --
> > 2.1.2
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
