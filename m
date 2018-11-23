From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Nov 2018 14:42:42 +0000
Subject: [PATCH V3 5/5] arm64/mm: Enable HugeTLB migration for contiguous
 bit HugeTLB pages
In-Reply-To: <1540299721-26484-6-git-send-email-anshuman.khandual@arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-6-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181123144241.GE3360@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 06:32:01PM +0530, Anshuman Khandual wrote:
> Let arm64 subscribe to the previously added framework in which architecture
> can inform whether a given huge page size is supported for migration. This
> just overrides the default function arch_hugetlb_migration_supported() and
> enables migration for all possible HugeTLB page sizes on arm64. With this,
> HugeTLB migration support on arm64 now covers all possible HugeTLB options.
> 
>         CONT PTE    PMD    CONT PMD    PUD
>         --------    ---    --------    ---
> 4K:        64K      2M        32M      1G
> 16K:        2M     32M         1G
> 64K:        2M    512M        16G
> 
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
