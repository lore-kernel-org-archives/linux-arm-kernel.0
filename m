From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Fri, 23 Nov 2018 20:38:27 +0530
Subject: [PATCH V3 0/5] arm64/mm: Enable HugeTLB migration
In-Reply-To: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <6cd51837-9d9c-af7a-6843-ef668a99e2ee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/23/2018 06:31 PM, Anshuman Khandual wrote:
> This patch series enables HugeTLB migration support for all supported
> huge page sizes at all levels including contiguous bit implementation.
> Following HugeTLB migration support matrix has been enabled with this
> patch series. All permutations have been tested except for the 16GB.
> 
>          CONT PTE    PMD    CONT PMD    PUD
>          --------    ---    --------    ---
> 4K:         64K     2M         32M     1G
> 16K:         2M    32M          1G
> 64K:         2M   512M         16G
> 
> First the series adds migration support for PUD based huge pages. It
> then adds a platform specific hook to query an architecture if a
> given huge page size is supported for migration while also providing
> a default fallback option preserving the existing semantics which just
> checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
> HugeTLB migration on arm64 and subscribe to this new platform specific
> hook by defining an override.
> 
> The second patch differentiates between movability and migratability
> aspects of huge pages and implements hugepage_movable_supported() which
> can then be used during allocation to decide whether to place the huge
> page in movable zone or not.
> 
> Changes in V3:
> 
> - Re-ordered patches 1 and 2 per Michal
> - s/Movability/Migratability/ in unmap_and_move_huge_page() per Naoya
> 
> Changes in V2: (https://lkml.org/lkml/2018/10/12/190)
> 
> - Added a new patch which differentiates migratability and movability
>   of huge pages and implements hugepage_movable_supported() function
>   as suggested by Michal Hocko.
> 
> Anshuman Khandual (5):
>   mm/hugetlb: Distinguish between migratability and movability
>   mm/hugetlb: Enable PUD level huge page migration
>   mm/hugetlb: Enable arch specific huge page size support for migration
>   arm64/mm: Enable HugeTLB migration
>   arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages

Hello Andrew,

This patch series has been reviewed and acked both for it's core MM and
arm64 changes. Could you please consider this series. Thank you.

- Anshuman
