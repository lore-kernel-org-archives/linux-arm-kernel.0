From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 3 Mar 2016 21:03:23 +0530
Subject: [PATCH v3 1/4] dmaengine: xilinx_vdma: Improve SG engine handling
In-Reply-To: <1456495434-11722-1-git-send-email-appanad@xilinx.com>
References: <1456495434-11722-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160303153323.GN11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 07:33:51PM +0530, Kedareswara rao Appana wrote:
> The current driver allows user to queue up multiple segments
> on to a single transaction descriptor. User will submit this single desc
> and in the issue_pending() we decode multiple segments and submit to SG HW engine.
> We free up the allocated_desc when it is submitted to the HW.
> 
> Existing code prevents the user to prepare multiple trasactions at same time as
> we are overwrite with the allocated_desc.
> 
> The best utilization of HW SG engine would happen if we collate the pending
> list when we start dma this patch updates the same.

Applied all. It is usually advisable to do cover letter using --cover-letter
for multi patch series

-- 
~Vinod
