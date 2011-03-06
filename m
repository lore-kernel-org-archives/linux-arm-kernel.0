From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 07 Mar 2011 01:15:20 +0530
Subject: [PATCH V2 00/13] dmaengine/dw_dmac: Extending support & minor
	fixes
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <1299440720.6974.158.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-03 at 15:47 +0530, Viresh Kumar wrote:
> Following set of patches extends dw_dmac support and fixes minor bugs.
> 
> Changes since V1:
> I had few more patches that i prepared today. I wasn't sure if i should
> add them to existing patchset, but as they are very much associated to this
> patchset, i added them here.
> 
> Following new patches have been added in V2:
> - dw_dmac: Replace module_init() with subsys_initcall()
> - dw_dmac: Change value of DWC_MAX_COUNT to 4095
> - dw_dmac: Changing type of src_master and dest_master to u8
> - dw_dmac: Setting Default Burst length for transfers as 16
> - Allow src/dst msize & flow controller to be configured at runtime
> - at32ap700x: Specify DMA Flow Controller, Src and Dst msize or burst size
> 
> Other than this following are changes after getting review comments on V1:
> - Added driver dependency on HAVE_CLK & fixed commit message issues
> - Added descriptive commit message in: "Calling dwc_scan_descriptors from..."
> - Aligned struct instance in: "Mark all tx_descriptors with..." 
> - Removed: "dw_dmac: call dwc_scan_descriptor from dwc_issue_pending..." as it
>   was already commited in linux-next.
> 
> Viresh KUMAR (1):
>   dw_dmac: Allow src/dst msize & flow controller to be configured at
>     runtime
> 
> Viresh Kumar (12):
>   dw_dmac: Remove compilation dependency from AVR32 and put on HAVE_CLK
>   dw_dmac: Replace module_init() with subsys_initcall()
>   dw_dmac: Move single descriptor from dwc->queue to dwc->active_list
>     in dwc_complete_all
>   dw_dmac: Calling dwc_scan_descriptors from dwc_tx_status() after
>     taking lock
>   dw_dmac: Adding support for 64 bit access width for memcpy xfers
>   dw_dmac: Change value of DWC_MAX_COUNT to 4095.
>   dw_dmac: Mark all tx_descriptors with DMA_CRTL_ACK after xfer finish
>   dw_dmac: Pass Channel Allocation Order from platform_data
>   dw_dmac: Pass Channel Priority from platform_data
>   dw_dmac: Changing type of src_master and dest_master to u8.
>   dw_dmac: Setting Default Burst length for transfers as 16.
>   avr32: at32ap700x: Specify DMA Flow Controller, Src and Dst msize or
>     burst size
> 
>  arch/avr32/mach-at32ap/at32ap700x.c |    9 +++++
>  drivers/dma/Kconfig                 |    2 +-
>  drivers/dma/dw_dmac.c               |   67 +++++++++++++++++++++++------------
>  drivers/dma/dw_dmac_regs.h          |    4 ++
>  include/linux/dw_dmac.h             |   43 +++++++++++++++++++++--
>  5 files changed, 98 insertions(+), 27 deletions(-)
> 
Thanks, Applied this series (13) and readl/writel fixes patch

-- 
~Vinod
