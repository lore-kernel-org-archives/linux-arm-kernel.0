From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Thu, 05 Mar 2015 13:20:03 -0800
Subject: [PATCH] iommu: arm-smmu: set a more appropriate DMA mask
In-Reply-To: <2ad6f0a7d198d607e252c420fef52d95dbe048c6.1425581413.git.robin.murphy@arm.com>
 (Robin Murphy's message of "Thu, 5 Mar 2015 18:56:36 +0000")
References: <2ad6f0a7d198d607e252c420fef52d95dbe048c6.1425581413.git.robin.murphy@arm.com>
Message-ID: <vnkw1tl3qgzg.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05 2015 at 10:56:36 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Since we use dma_map_page() as an architecture-independent means of
> making page table updates visible to non-coherent SMMUs, we need to
> have a suitable DMA mask set to discourage the DMA mapping layer from
> creating bounce buffers and flushing those instead, if said page tables
> happen to lie outside the default 32-bit mask.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Mitchel Humpherys <mitchelh@codeaurora.org>

Thanks Robin!


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
