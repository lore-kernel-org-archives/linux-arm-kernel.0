From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Sat, 23 Apr 2016 05:37:57 +0000
Subject: [PATCH v2 1/2] Documentation: DT: vdma: Add clock support for vdma
In-Reply-To: <20160422193707.GA16116@rob-hp-laptop>
References: <1461152599-28858-1-git-send-email-appanad@xilinx.com>
 <20160422193707.GA16116@rob-hp-laptop>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57A1D8@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Saturday, April 23, 2016 1:07 AM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> vinod.koul at intel.com; dan.j.williams at intel.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi <anirudh@xilinx.com>; Punnaiah Choudary Kalluri
> <punnaia@xilinx.com>; Shubhrajyoti Datta <shubhraj@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; dmaengine at vger.kernel.org
> Subject: Re: [PATCH v2 1/2] Documentation: DT: vdma: Add clock support for
> vdma
> 
> On Wed, Apr 20, 2016 at 05:13:18PM +0530, Kedareswara rao Appana wrote:
> > This patch updates the binding doc with clock description for vdma.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v2:
> > --> Listed down all the clocks supported by the h/w
> >     as suggested by the Datta.
> > --> Used IP clock names instead of shortcut clock names.
> >
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 8
> > ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index fcc2b65..afe9eb7 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > @@ -21,6 +21,11 @@ Required properties:
> >  - dma-channel child node: Should have at least one channel and can have up
> to
> >  	two channels per device. This node specifies the properties of each
> >  	DMA channel (see child node properties below).
> > +- clocks: Input clock specifier. Refer to common clock bindings.
> > +- clock-names: List of input clocks "s_axi_lite_aclk", "m_axi_mm2s_aclk"
> > +	       "m_axi_s2mm_aclk", "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
> > +	       (list of input cloks may vary based on the ip configuration.
> 
> s/cloks/clocks/
> 
> > +		see clock bindings for more info).
> 
> This does not make sense. The common clock binding is going to tell me more
> about how the clocks vary?

I have fixed these comments in the other version (v4) you acked that patch...

Regards,
Kedar.

> 
> You need to define here how the clocks can vary.
