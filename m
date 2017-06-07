From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Jun 2017 15:58:55 +0100
Subject: [PATCH v2 1/3] arm64: hugetlb: Fix huge_pte_offset to return
 poisoned page table entries
In-Reply-To: <20170517152336.6052-2-punit.agrawal@arm.com>
References: <20170517152336.6052-1-punit.agrawal@arm.com>
 <20170517152336.6052-2-punit.agrawal@arm.com>
Message-ID: <20170607145855.cu5tob2uck2xbvxm@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:23:34PM +0100, Punit Agrawal wrote:
> When memory failure is enabled, a poisoned hugepage pte is marked as a
> swap entry. huge_pte_offset() does not return the poisoned page table
> entries when it encounters PUD/PMD hugepages.
> 
> This behaviour of huge_pte_offset() leads to error such as below when
> munmap is called on poisoned hugepages.
> 
> [  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.
> 
> Fix huge_pte_offset() to return the poisoned pte which is then
> appropriately handled by the generic layer code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Acked-by: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Woods <dwoods@mellanox.com>

Since the patch matches my suggestions in v1:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
