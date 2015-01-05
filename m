From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Jan 2015 09:03:48 -0500
Subject: [PATCH v3 2/2] ahci_xgene: Fix the DMA state machine lockup for
 the ATA_CMD_PACKET PIO mode command.
In-Reply-To: <1419823367-11279-3-git-send-email-stripathi@apm.com>
References: <1419823367-11279-1-git-send-email-stripathi@apm.com>
 <1419823367-11279-3-git-send-email-stripathi@apm.com>
Message-ID: <20150105140348.GF15833@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 08:52:47AM +0530, Suman Tripathi wrote:
> This patch addresses the issue with ATA_CMD_PACKET pio mode
> command for enumeration and device detection with ATAPI devices.
> The X-Gene AHCI controller has an errata in which it cannot clear
> the BSY bit after the PIO setup FIS. The dma state machine enters
> CMFatalErrorUpdate state and locks up.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Ah, you already posted the updated versions.  Applied these instead.

Thanks.

-- 
tejun
