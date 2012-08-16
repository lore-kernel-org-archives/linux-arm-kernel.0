From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Aug 2012 23:29:12 +0100
Subject: [PATCH 1/3] dmaengine: add TI EDMA DMA engine driver
In-Reply-To: <1345153471-22757-2-git-send-email-mporter@ti.com>
References: <1345153471-22757-1-git-send-email-mporter@ti.com>
 <1345153471-22757-2-git-send-email-mporter@ti.com>
Message-ID: <20120816222912.GA15883@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 05:44:29PM -0400, Matt Porter wrote:
> Add a DMA engine driver for the TI EDMA controller. This driver
> is implemented as a wrapper around the existing DaVinci private
> DMA implementation. This approach allows for incremental conversion
> of each peripheral driver to the DMA engine API. The EDMA driver
> supports slave transfers but does not yet support cyclic transfers.

Have you looked at the virt-dma support?  That should allow you to
avoid some common errors, like forgetting that stuff submitted but
not issued should not be started even if the channel is currently
running.
