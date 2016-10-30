From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 14:26:49 +0000
Subject: [PATCH] arm64: Remove pointless WARN_ON in DMA teardown
In-Reply-To: <74f5ae2ead8bb8fa9fabcf88b5962885b29eb2d5.1477505971.git.robin.murphy@arm.com>
References: <74f5ae2ead8bb8fa9fabcf88b5962885b29eb2d5.1477505971.git.robin.murphy@arm.com>
Message-ID: <20161030142649.ertqauqeaykxlpcf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 07:19:31PM +0100, Robin Murphy wrote:
> We expect arch_teardown_dma_ops() to be called very late in a device's
> life, after it has been removed from its bus, and thus after the IOMMU
> bus notifier has run. As such, even if this funny little check did make
> sense, it's unlikely to achieve what it thinks it's trying to do anyway.
> It's a residual trace of an earlier implementation which didn't belong
> here from the start; belatedly snuff it out.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Queued for 4.10. Thanks.

-- 
Catalin
