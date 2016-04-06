From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 6 Apr 2016 22:13:59 +0000
Subject: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan prefix
 to dma-chan
In-Reply-To: <57057C9B.8040804@metafoo.de>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
 <1459959335-24083-2-git-send-email-appanad@xilinx.com>
 <20160406162022.GS23198@xsjsorenbubuntu>
 <C246CAC1457055469EF09E3A7AC4E11A4A57364B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57057C9B.8040804@metafoo.de>
Message-ID: <1459980839.3136.87.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-06 at 23:16 +0200, Lars-Peter Clausen wrote:
> On 04/06/2016 06:25 PM, Appana Durga Kedareswara Rao wrote:
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > > > +++
> > > > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > > > @@ -24,8 +24,8 @@ Optional properties:
> > > >  	{3}, flush s2mm channel
> > > > 
> > > >  Required child node properties:
> > > > -- compatible: It should be either "xlnx,axi-vdma-mm2s-channel"
> > > > or
> > > > -	"xlnx,axi-vdma-s2mm-channel".
> > > > +- compatible: It should be either "xlnx,axi-dma-mm2s-channel"
> > > > or
> > > > +	"xlnx,axi-dma-s2mm-channel".
> > > 
> > > This change is not backwards compatible and breaks every user of
> > > the current
> > > binding.
> > 
> > This commit http://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-
> > dma.git/commit/?h=next&id=8e66e7d682b04f7141f8ae666908c8dcd7fc0bfa 
> > Renames xilinx_vdma_ prefix to xilinx_dma which includes renaming of
> > the above properties.

That patch changes driver from vdma to dma. It does not change property
name!

> > The patch (dmaengine: vdma: Rename xilinx_vdma_ prefix to
> > xilinx_dma) already got applied in the dma-next tree.
> > That's why sent this patch to sync with the current driver I mean
> > latest driver.
> 
> The correct solution for this is to revert that part of the change
> ASAP,
> since, as Soeren pointed out, it breaks all existing users.

No the commit applied is only the name changes inside the driver. They
don't break anything yet. IIUC this patch breaks not the applied one..

Thanks
-- 
~Vinod
