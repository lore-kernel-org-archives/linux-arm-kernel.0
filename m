From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 11 Oct 2011 11:13:31 -0700
Subject: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
	mapper for DMA-mapping
In-Reply-To: <00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
	<594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
	<001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E37225197F8@HQMAIL04.nvidia.com>
	<00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek,

>It looks that You have simplified arm_iommu_map_sg() function too much. 
>The main advantage of the iommu is to map scattered memory pages into 
>contiguous dma address space. DMA-mapping is allowed to merge consecutive
>entries in the scatter list if hardware supports that.
>http://article.gmane.org/gmane.linux.kernel/1128416

I would update arm_iommu_map_sg() back to coalesce the sg list.

>I'm not sure if mmc drivers are aware of coalescing the SG entries together.
>If not the code must be updated to use dma_sg_len() and the dma entries
>number returned from dma_map_sg() call.

MMC drivers seem to be aware of coalescing the SG entries together as they are using dma_sg_len().

Let me test and update the patch.

--
nvpublic
