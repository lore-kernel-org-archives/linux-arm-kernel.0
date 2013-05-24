From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:18:16 +0100
Subject: [PATCH 03/11] mm: hugetlb: Copy general hugetlb code from x86
 to mm.
In-Reply-To: <1369328878-11706-4-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524111816.GH18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:50PM +0100, Steve Capper wrote:
> The huge_pte_alloc, huge_pte_offset and follow_huge_p[mu]d
> functions in x86/mm/hugetlbpage.c do not rely on any architecture
> specific knowledge other than the fact that pmds and puds can be
> treated as huge ptes.
> 
> To allow other architectures to use this code (and reduce the need
> for code duplication), this patch copies these functions into mm,
> replaces the use of pud_large with pud_huge and provides a config
> flag to activate them:
> CONFIG_ARCH_WANT_GENERAL_HUGETLB

BTW, I think it's worth mentioning that pud_large is inline while
pud_huge is not.

-- 
Catalin
