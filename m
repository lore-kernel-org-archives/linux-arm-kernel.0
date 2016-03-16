From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Mar 2016 09:06:05 +0900
Subject: [PATCHv2 00/31] ARM: dts: r8a779[0-4]: Reference both DMA
 controllers
In-Reply-To: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160316000603.GE6912@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 01:41:37PM +0100, Niklas S?derlund wrote:
> Hi,
> 
> R-Car Gen2 have two DMA controllers, which are equivalent. However DMA
> slaves were tied only to a single DMA controller in .dtsi. This series
> add references to to both DMA controllers for all nodes that previously
> only referenced one of them. It also adds dma references to the SDHI
> nodes for r8a7794 which according to the datasheet should work but I
> have not access to HW to verify.
> 
> Tested on Koelsch (r8a7791) by altering the compatible value of either
> dmac0 or dmac1 and verifying that the DMA slaves pick the DMA controller
> that is instantiated.
> 
> For your convince the series can be fetched from
> https://git.ragnatech.se/linux rcar-dmas-dt-2
> 
> * Changes since v1
> - Rebase on top of renesas-devel-20160315-v4.5 and add dmas references
>   new nodes (r8a7790: scif2 r8a7793: i2c6,i2c7,i2c8).
> - Correct error in commit message 31/31 (s/QSPI/MMCIF).
> - Collect Ack and Reviewed tags from Geert.

Thanks Niklas,

I have queued these up for v4.7.
