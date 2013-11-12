From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Nov 2013 09:18:08 +0530
Subject: [PATCH v2] dma: edma: Add support for Cyclic DMA
In-Reply-To: <1383255083-31186-1-git-send-email-joelf@ti.com>
References: <1383255083-31186-1-git-send-email-joelf@ti.com>
Message-ID: <20131112034808.GB8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 04:31:23PM -0500, Joel Fernandes wrote:
> Using the PaRAM configuration function that we split for reuse by the
> different DMA types, we implement Cyclic DMA support.
> For the cyclic case, we pass different configuration parameters to this
> function, and handle all the Cyclic-specific functionality separately.
> 
> Callbacks to the DMA users are handled using vchan_cyclic_callback in
> the virt-dma layer. Linking is handled the same way as the slave SG case
> except for the last slot where we link it back to the first one in a
> cyclic fashion.
> 
> For continuity, we check for cases where no.of periods is great than the
> MAX number of slots the driver can allocate for a particular descriptor
> and error out on such cases.
Applied, thanks

~Vinod
