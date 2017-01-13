From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 13 Jan 2017 10:59:39 +0530
Subject: [PATCH v5 1/3] dmaengine: xilinx_dma: Check for channel idle
 state before submitting dma descriptor
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A666658@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1483771530-8545-1-git-send-email-appanad@xilinx.com>
 <1483771530-8545-2-git-send-email-appanad@xilinx.com>
 <20170110062349.GY3573@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A666658@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20170113052939.GP3573@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 04:28:11AM +0000, Appana Durga Kedareswara Rao wrote:
> Hi Vinod,
> 
> 	Thanks for the review...
> > 
> > On Sat, Jan 07, 2017 at 12:15:28PM +0530, Kedareswara rao Appana wrote:
> > > Add channel idle state to ensure that dma descriptor is not
> > > submitted when VDMA engine is in progress.
> > 
> > any reason why you want to make your own varible and not use the HW to
> > query
> > as done earlier. It is not clear to me why that is removed from description
> 
> We need to poll for a bit in the status register to know the dma state.
> We are currently doing that in the driver hot path
> To avoid this using own variables.

It would be worthwhile to document these, down the line people may not
remeber the motivation


-- 
~Vinod
