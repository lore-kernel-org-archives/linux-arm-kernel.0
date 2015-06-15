From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Mon, 15 Jun 2015 16:04:25 +0000
Subject: [PATCH v2 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <CAM=Q2ctpOhxryYqgiHDQry7Q_1noYGEX4pYg+tp+wLgV9=X1hw@mail.gmail.com>
References: <1434378982-30184-1-git-send-email-punnaia@xilinx.com>
 <1434378982-30184-2-git-send-email-punnaia@xilinx.com>
 <CAM=Q2ctpOhxryYqgiHDQry7Q_1noYGEX4pYg+tp+wLgV9=X1hw@mail.gmail.com>
Message-ID: <03CA77BA8AF6F1469AEDFBDA1322A7B7495B1048@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shubhrajyoti Datta [mailto:omaplinuxkernel at gmail.com]
> Sent: Monday, June 15, 2015 8:35 PM
> To: Punnaiah Choudary Kalluri
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; Kumar Gala; Michal Simek; Soren Brinkmann;
> vinod.koul at intel.com; dan.j.williams at intel.com;
> devicetree at vger.kernel.org; Linux Kernel Mailing List; kpc528 at gmail.com;
> kalluripunnaiahchoudary at gmail.com; dmaengine at vger.kernel.org;
> Punnaiah Choudary Kalluri; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/2] dma: Add Xilinx zynqmp dma engine driver
> support
> 
> On Mon, Jun 15, 2015 at 8:06 PM, Punnaiah Choudary Kalluri
> <punnaiah.choudary.kalluri@xilinx.com> wrote:
> > Added the basic driver for zynqmp dma engine used in Zynq
> > UltraScale+ MPSoC. The initial release of this driver supports
> > only memory to memory transfers.
> >
> > Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> > ---
> <snip>
> 
> > +/**
> > + * zynqmp_dma_chan_is_idle - Provides the channel idle status
> > + * @chan: ZynqMP DMA DMA channel pointer
> > + *
> > + * Return: '1' if the channel is idle otherwise '0'
> > + */
> > +static int zynqmp_dma_chan_is_idle(struct zynqmp_dma_chan *chan)
> 
> maybe this could return bool.

Ok. I will modify the return type.

Regards,
Punnaiah
> 
> > +{
> > +       u32 regval;
> > +
> > +       regval = readl(chan->regs + STATUS);
> > +       if (regval & STATUS_BUSY)
> > +               return 0;
> > +
> > +       return 1;
> > +}
> > +
