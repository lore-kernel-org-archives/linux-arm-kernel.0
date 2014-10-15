From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 15 Oct 2014 19:02:48 +0530
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <20141015124527.GA20034@leverpostej>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <20141015124527.GA20034@leverpostej>
Message-ID: <20141015133248.GQ1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 01:45:28PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Wed, Oct 15, 2014 at 01:00:36PM +0100, Srikanth Thokala wrote:
> > This is the driver for the AXI Direct Memory Access (AXI DMA)
> > core, which is a soft Xilinx IP core that provides high-
> > bandwidth direct memory access between memory and AXI4-Stream
> > type target peripherals.
> > 
> > This module works on Zynq (ARM Based SoC) and Microblaze platforms.
> > 
> > Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> > ---
> > Changes in v4:
> > - Add direction field to VDMA descriptor structure and removed from
> >   channel structure to avoid duplication.
> > - Check for DMA idle condition before changing the configuration.
> > - Residue is being calculated in complete_descriptor() and is reported
> >   to slave driver.
> > 
> > Changes in v3:
> > - Rebased on 3.16-rc7
> > 
> > Changes in v2:
> > - Simplified the logic to set SOP and APP words in prep_slave_sg().
> > - Corrected function description comments to match the return type.
> > - Fixed some minor comments as suggested by Andy, Thanks.
> 
> This patch has come without the necessary device tree binding document,
> and I was not able to find an existing binding document upstream (I
> searched for "xlnx,axi-dma-1.00.a" and "axi-dma").
which tree did you grep. 

This is present in slave-dmaengine.git 

commit ddc643630f5deb1995d191719086b64873c67a44
Author: Srikanth Thokala <sthokal@xilinx.com>
Date:   Mon Jul 28 17:47:48 2014 +0530

    dma: Add Xilinx AXI DMA DT Binding Documentation

    Device-tree binding documentation of Xilinx DMA Engine

    Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

> 
> The driver expects a non-trivial set of properties, so a binding
> document is essential for users. Additionally, checkpatch.pl should
> scream regarding the undocumented comaptible string.
> 
> Please put together a binding document.
> 
> Thanks,
> Mark.

-- 
