From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Jan 2015 11:27:19 +0000
Subject: [PATCH] Add support for CONFIG_ARM64_DMA_USE_IOMMU.
In-Reply-To: <1422379495-10268-1-git-send-email-stripathi@apm.com>
References: <1422379495-10268-1-git-send-email-stripathi@apm.com>
Message-ID: <20150128112718.GE6646@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 05:24:54PM +0000, Suman Tripathi wrote:
> This patch implements the support for ARM64_DMA_USE_IOMMU
> ported from ARM 32-bit.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
> 
> Suman Tripathi (1):
>   arm64: dma-mapping: Support for ARM64_DMA_USE_IOMMU.
> 
>  arch/arm64/Kconfig                 |  24 ++
>  arch/arm64/include/asm/device.h    |   9 +
>  arch/arm64/include/asm/dma-iommu.h |  48 +++
>  arch/arm64/mm/dma-mapping.c        | 611 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 692 insertions(+)
>  create mode 100644 arch/arm64/include/asm/dma-iommu.h

I guess there is an overlap with this thread:

http://thread.gmane.org/gmane.linux.kernel.iommu/8213

I would rather go for a more generic solution that Robin (cc'ed) is
trying to implement.

-- 
Catalin
