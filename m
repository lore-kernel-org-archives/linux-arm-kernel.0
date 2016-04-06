From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 6 Apr 2016 16:25:58 +0000
Subject: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan prefix
 to dma-chan
In-Reply-To: <20160406162022.GS23198@xsjsorenbubuntu>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
 <1459959335-24083-2-git-send-email-appanad@xilinx.com>
 <20160406162022.GS23198@xsjsorenbubuntu>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57364B@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,


> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Wednesday, April 06, 2016 9:50 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; vinod.koul at intel.com; dan.j.williams at intel.com;
> Appana Durga Kedareswara Rao <appanad@xilinx.com>;
> moritz.fischer at ettus.com; laurent.pinchart at ideasonboard.com;
> luis at debethencourt.com; Srikanth Vemula <svemula@xilinx.com>; Anirudha
> Sarangi <anirudh@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> dmaengine at vger.kernel.org
> Subject: Re: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan
> prefix to dma-chan
> 
> On Wed, 2016-04-06 at 21:45:31 +0530, Kedareswara rao Appana wrote:
> > This patch renames the vdma-mm2s-channel/vdma-s2mm-channel
> > property with dma-mm2s-channel/dma-s2mm-channel to sync with the
> > driver.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v3:
> > ---> New patch.
> >
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 8
> > ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index a86737c..762938f 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > @@ -24,8 +24,8 @@ Optional properties:
> >  	{3}, flush s2mm channel
> >
> >  Required child node properties:
> > -- compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
> > -	"xlnx,axi-vdma-s2mm-channel".
> > +- compatible: It should be either "xlnx,axi-dma-mm2s-channel" or
> > +	"xlnx,axi-dma-s2mm-channel".
> 
> This change is not backwards compatible and breaks every user of the current
> binding.

This commit http://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?h=next&id=8e66e7d682b04f7141f8ae666908c8dcd7fc0bfa 
Renames xilinx_vdma_ prefix to xilinx_dma which includes renaming of the above properties.
The patch (dmaengine: vdma: Rename xilinx_vdma_ prefix to xilinx_dma) already got applied in the dma-next tree.
That's why sent this patch to sync with the current driver I mean latest driver.

Regards,
Kedar.

> 
> 	S?ren
