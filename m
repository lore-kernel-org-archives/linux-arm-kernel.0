From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 6 Jun 2017 16:45:38 +0100
Subject: [PATCH] arm64: dts: juno: Enable some SMMUs
In-Reply-To: <eeb81dbbd7ddfbbccb961c0f20c5cb90f120e89f.1495110010.git.robin.murphy@arm.com>
References: <eeb81dbbd7ddfbbccb961c0f20c5cb90f120e89f.1495110010.git.robin.murphy@arm.com>
Message-ID: <5e24adfa-3342-f331-1ed3-ed32ebf164cb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 18/05/17 13:23, Robin Murphy wrote:
> The IOMMU-backed DMA API support has now been in place for a while and
> proven stable, so there's no real need to keep most of Juno's SMMUs
> disabled. The USB, HDLCDs, and CoreSight ETR all just need to map RAM
> buffers for DMA - enabling their SMMUs obviates CPU bounce buffering for
> USB's streaming DMA to the upper memory bank, and lets the other two
> allocate their relatively large coherent buffers without pressuring CMA.
> 
> Some more software work is still needed for the DMA-330 and PCIe before
> those can accommodate SMMU translation correctly in all cases, so we
> leave those alone for now.

Out of curiosity, what is missing for DMA-330? I can use dmatest over SMMU
on my juno-r1 by enabling the node, but I don't have any complex workload
yet. Guest pass-through is really unreliable and I'm trying to figure out why.

Thanks,
Jean
