From: mporter@ti.com (Matt Porter)
Date: Tue, 21 Aug 2012 14:20:04 -0400
Subject: [PATCH 1/3] dmaengine: add TI EDMA DMA engine driver
In-Reply-To: <1345153471-22757-2-git-send-email-mporter@ti.com>
References: <1345153471-22757-1-git-send-email-mporter@ti.com>
 <1345153471-22757-2-git-send-email-mporter@ti.com>
Message-ID: <20120821182004.GA32420@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 05:44:29PM -0400, Matt Porter wrote:
> Add a DMA engine driver for the TI EDMA controller. This driver
> is implemented as a wrapper around the existing DaVinci private
> DMA implementation. This approach allows for incremental conversion
> of each peripheral driver to the DMA engine API. The EDMA driver
> supports slave transfers but does not yet support cyclic transfers.

I got my hands on a AM18x WL12xx module so I could test MMC1 and this
exposed some bugs in the driver's handling of the second EDMA controller
case. DA850/OMAP-L138/AM1x have this second EDMA controller. I've
addressed this in v2 which will be posted shortly.

I'm expecting to receive a DM646x EVM RSN so I can cover testing that
part as well.

-Matt
