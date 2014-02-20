From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Feb 2014 17:00:36 +0000
Subject: [PATCH 2/3] arm64: mm: Route pmd thp functions through pte
 equivalents
In-Reply-To: <20140212103237.GA12778@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
 <1391696171-8922-3-git-send-email-steve.capper@linaro.org>
 <20140212101423.GC29702@arm.com>
 <20140212103237.GA12778@linaro.org>
Message-ID: <20140220170035.GB7651@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:32:38AM +0000, Steve Capper wrote:
> On Wed, Feb 12, 2014 at 10:14:23AM +0000, Catalin Marinas wrote:
> > On Thu, Feb 06, 2014 at 02:16:10PM +0000, Steve Capper wrote:
> > > Rather than have separate hugetlb and transparent huge page pmd
> > > manipulation functions, re-wire our thp functions to simply call the
> > > pte equivalents.
> > 
> > That's one thing I don't like about hugetlb, casting pmds to ptes. Do we
> > actually save much in terms of code clean-up by doing this?
> 
> At the moment we have ptes and hugetlb ptes behaving in the same way so
> they both make use of PTE_WRITE. I thought it would be more logical to
> tie the THP code to the pte manipulation functions too rather than
> duplicate the PTE_WRITE logic in a separate PMD_WRITE. This makes
> future pte changes apply to THP too automatically (along with hugetlb).

OK, let's go with this, it's difficult to change hugetlb the other way.

BTW, powerpc and tile heavily simplify this using macros and
pte_pmd/pmd_pte macros.

-- 
Catalin
