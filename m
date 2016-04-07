From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 7 Apr 2016 04:03:09 +0000
Subject: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan prefix
 to dma-chan
In-Reply-To: <1459988606.3136.88.camel@intel.com>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
 <1459959335-24083-2-git-send-email-appanad@xilinx.com>
 <20160406162022.GS23198@xsjsorenbubuntu>
 <C246CAC1457055469EF09E3A7AC4E11A4A57364B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57057C9B.8040804@metafoo.de> <1459980839.3136.87.camel@intel.com>
 <20160406230014.GC16193@xsjsorenbubuntu>
 <1459988606.3136.88.camel@intel.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57384E@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: Koul, Vinod [mailto:vinod.koul at intel.com]
> Sent: Thursday, April 07, 2016 5:53 AM
> To: Soren Brinkmann <sorenb@xilinx.com>
> Cc: lars at metafoo.de; linux-kernel at vger.kernel.org; pawel.moll at arm.com;
> Appana Durga Kedareswara Rao <appanad@xilinx.com>;
> luis at debethencourt.com; moritz.fischer at ettus.com; robh+dt at kernel.org;
> Srikanth Vemula <svemula@xilinx.com>; Michal Simek <michals@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>; devicetree at vger.kernel.org; Soren
> Brinkmann <sorenb@xilinx.com>; Williams, Dan J <dan.j.williams@intel.com>;
> mark.rutland at arm.com; galak at codeaurora.org; ijc+devicetree at hellion.org.uk;
> dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> laurent.pinchart at ideasonboard.com
> Subject: Re: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan
> prefix to dma-chan
> 
> On Wed, 2016-04-06 at 16:00 -0700, S?ren Brinkmann wrote:
> > On Wed, 2016-04-06 at 22:13:59 +0000, Koul, Vinod wrote:
> > > On Wed, 2016-04-06 at 23:16 +0200, Lars-Peter Clausen wrote:
> > > > On 04/06/2016 06:25 PM, Appana Durga Kedareswara Rao wrote:
> > > > > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.t
> > > > > > > xt
> > > > > > > @@ -24,8 +24,8 @@ Optional properties:
> > > > > > >  	{3}, flush s2mm channel
> > > > > > >
> > > > > > >  Required child node properties:
> > > > > > > -- compatible: It should be either "xlnx,axi-vdma-mm2s
> > > > > > > -channel"
> > > > > > > or
> > > > > > > -	"xlnx,axi-vdma-s2mm-channel".
> > > > > > > +- compatible: It should be either "xlnx,axi-dma-mm2s
> > > > > > > -channel"
> > > > > > > or
> > > > > > > +	"xlnx,axi-dma-s2mm-channel".
> > > > > >
> > > > > > This change is not backwards compatible and breaks every user
> > > > > > of the current binding.
> > > > >
> > > > > This commit
> > > > > http://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-
> > > > >
> dma.git/commit/?h=next&id=8e66e7d682b04f7141f8ae666908c8dcd7fc0b
> > > > > fa
> > > > > Renames xilinx_vdma_ prefix to xilinx_dma which includes
> > > > > renaming of the above properties.
> > >
> > > That patch changes driver from vdma to dma. It does not change
> > > property name!
> >
> > It does. Unfortunately there are no line numbers on that website,
> > hence here an excerpt from the commit you mention:
> > @@ -1220,26 +1220,26 @@ static int xilinx_vdma_chan_probe(struct
> > xilinx_vdma_device *xdev,
> >  	if (!has_dre)
> >  		xdev->common.copy_align = fls(width - 1);
> >
> > -	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s
> > -channel")) {
> > +	if (of_device_is_compatible(node, "xlnx,axi-dma-mm2s
> > -channel")) {
> >  		chan->direction = DMA_MEM_TO_DEV;
> >  		chan->id = 0;
> 
> Right, missed that somehow.
> 
> Am dropping the patch

Will fix this part and will include this patch in v4 series...

Regards,
Kedar.

> 
> --
> ~Vinod
