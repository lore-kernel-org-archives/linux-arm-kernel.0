From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 27 Apr 2016 07:33:22 +0000
Subject: [PATCH v7 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <57206632.7010508@metafoo.de>
References: <1461740729-30715-1-git-send-email-appanad@xilinx.com>
 <57206632.7010508@metafoo.de>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57B840@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: Wednesday, April 27, 2016 12:42 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>;
> robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> vinod.koul at intel.com; dan.j.williams at intel.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi <anirudh@xilinx.com>; Punnaiah Choudary Kalluri
> <punnaia@xilinx.com>
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; dmaengine at vger.kernel.org
> Subject: Re: [PATCH v7 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
> device tree binding documentation
> 
> On 04/27/2016 09:05 AM, Kedareswara rao Appana wrote:
> [...]
> > +- xlnx,include-sg	: Indicates the controller to operate in simple or
> > +			  scatter gather dma mode
> > +- xlnx,ratectrl		: Scheduling interval in terms of clock cycles for
> > +			  source AXI transaction
> > +- xlnx,overfetch	: Tells whether the channel is allowed to over
> > +			  fetch the data
> > +- xlnx,src-issue	: Number of AXI outstanding transactions on source
> side
> > +- xlnx,src-burst-len	: AXI length for data read. Support only power of
> > +			  2 byte values.
> > +- xlnx,dst-burst-len	: AXI length for data write. Support only power of
> 
> These are all software runtime configuration parameters that you'd want to
> change at runtime depending on which peripheral you are targeting with a
> specific DMA transfer. These really do not belong into the devicetree.

You mean to have a separate config structure in the driver and handle the above parameters
Through that structure???

I understand that above will work for slave dma transfer types what about memory to memory
Transfers where we don't have provision to the use this parameters...

Regards,
Kedar.
