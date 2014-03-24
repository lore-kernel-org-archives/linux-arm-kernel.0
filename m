From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 10:33:03 +0000
Subject: [PATCHv2 1/3] arm64: Implement custom mmap functions for dma
 mapping
In-Reply-To: <1394826745-24191-1-git-send-email-lauraa@codeaurora.org>
References: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
 <1394826745-24191-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140324103302.GB3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 07:52:23PM +0000, Laura Abbott wrote:
> The current dma_ops do not specify an mmap function so maping
> falls back to the default implementation. There are at least
> two issues with using the default implementation:
> 
> 1) The pgprot is always pgprot_noncached (strongly ordered)
> memory even with coherent operations
> 2) dma_common_mmap calls virt_to_page on the remapped non-coherent
> address which leads to invalid memory being mapped.
> 
> Fix both these issue by implementing a custom mmap function which
> correctly accounts for remapped addresses and sets vm_pg_prot
> appropriately.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

I thought there was still some update needed to this series but it turns
out that patch 2/3 was what I was expecting already, so I merged the
first two patches (with minor changes for s/arm64_/__/ prefix). Patch 3
seems to be folded onto my patch already.

Thanks.

-- 
Catalin
