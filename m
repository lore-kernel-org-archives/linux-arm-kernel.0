From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 16:54:20 +0100
Subject: [PATCH v6 3/3] arm64: hibernate: Support DEBUG_PAGEALLOC
In-Reply-To: <1472059650-591-4-git-send-email-james.morse@arm.com>
References: <1472059650-591-1-git-send-email-james.morse@arm.com>
 <1472059650-591-4-git-send-email-james.morse@arm.com>
Message-ID: <20160825155420.GJ20748@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 06:27:30PM +0100, James Morse wrote:
> DEBUG_PAGEALLOC removes the valid bit of page table entries to prevent
> any access to unallocated memory. Hibernate uses this as a hint that those
> pages don't need to be saved/restored. This patch adds the
> kernel_page_present() function it uses.
> 
> hibernate.c copies the resume kernel's linear map for use during restore.
> Add _copy_pte() to fill-in the holes made by DEBUG_PAGEALLOC in the resume
> kernel, so we can restore data the original kernel had at these addresses.
> 
> Finally, DEBUG_PAGEALLOC means the linear-map alias of KERNEL_START to
> KERNEL_END may have holes in it, so we can't lazily clean this whole
> area to the PoC. Only clean the new mmuoff region, and the kernel/kvm
> idmaps.
> 
> This reverts commit da24eb1f3f9e2c7b75c5f8c40d8e48e2c4789596.
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
