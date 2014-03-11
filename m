From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Mar 2014 18:26:00 +0000
Subject: Query on patch to be upstream ?
In-Reply-To: <1394561059-29307-1-git-send-email-lauraa@codeaurora.org>
References: <20140311121500.GH31104@arm.com>
 <1394561059-29307-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140311182600.GB50212@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 06:04:19PM +0000, Laura Abbott wrote:
> With one caveat below, you can add
> 
> Tested-by: Laura Abbott <lauraa@codeaurora.org>

Thanks.

> From: Laura Abbott <lauraa@codeaurora.org>
> Date: Thu, 6 Mar 2014 21:05:41 -0800
> Subject: [PATCH] arm64: Use custom mmap function for noncoherent dma ops
> 
> The non-coherent dma ops remap memory with appropriate attributes.
> This remapped address cannot be used with virt_to_page which
> dma_common_mmap uses. Implement a custom (but very similar) function
> which correctly calculates the physical address and remaps to userspace.

Looking at the coherent implementation, I think we also have a
(performance) problem with dma_common_mmap(). It uses pgprot_noncached()
by default and if the DMA is coherent we don't really need strongly
ordered memory.

Would you mind writing a __dma_common_mmap() for arm64 with separate
coherent/non-coherent dma mmap functions that set the vm_page_prot
accordingly?

Thanks.

-- 
Catalin
