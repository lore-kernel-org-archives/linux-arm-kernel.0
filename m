From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Feb 2012 14:22:07 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <201202291231.52151.arnd@arndb.de>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
 <201202291231.52151.arnd@arndb.de>
Message-ID: <20120229142207.GD17745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 12:31:51PM +0000, Arnd Bergmann wrote:
> On Monday 13 February 2012, Bill Carson wrote:
> > +
> > +/* 2M and 16M hugepage linux ptes are stored in mmu_context_t->huge_linux_pte
> > + *
> > + * 2M hugepage
> > + * ===========
> > + * one huge linux pte caters to two HW ptes,
> > + *
> 
> I think this needs more explanation. Why do you use a 2MB hugepage with two ptes here?
> Wouldn't it be more logical to use 1MB hugepages?

That's because how pgd_t is defined for the classic MMU (PMD_SHIFT also
being 21). I think Bill explained in the first series of the patch why
using 1MB for huge pages doesn't go that well. But I agree, the
explanation should go in here as well.

-- 
Catalin
