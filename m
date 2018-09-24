From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Sep 2018 17:25:50 +0100
Subject: [PATCH V2 0/2] Fixes for contiguous hugetlb
In-Reply-To: <20180921153405.10090-1-steve.capper@arm.com>
References: <20180921153405.10090-1-steve.capper@arm.com>
Message-ID: <20180924162549.GC12461@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 04:34:03PM +0100, Steve Capper wrote:
> This patch series addresses a couple of issues found with contiguous hugetlb.
> 
> 1) It is possible for old hugetlb's to be created by remove_migration_pte, the
>    first patch adjusts the code to capture any young ptes that could have been
>    created by hardware dirty bit management.
> 
> 2) huge_ptep_set_access_flags has been changed in the second patch to prevent it
>    from unnecessarily invalidating contiguous hugetlb mappings (which also stops
>    it from potentially evoking back-to-back page faults).

Thanks Steve, these look good to me. I'll pick them up as fixes.

Will
