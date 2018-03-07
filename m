From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 7 Mar 2018 23:22:24 +0000
Subject: [PATCH 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180307150127.1e09e9826e0f2c80ce42fa4d@linux-foundation.org>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-3-toshi.kani@hpe.com>
 <20180307150127.1e09e9826e0f2c80ce42fa4d@linux-foundation.org>
Message-ID: <1520467641.2693.52.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-07 at 15:01 -0800, Andrew Morton wrote:
> On Wed,  7 Mar 2018 11:32:27 -0700 Toshi Kani <toshi.kani@hpe.com> wrote:
> 
> > Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> > clear a given pud/pmd entry and free up lower level page table(s).
> > Address range associated with the pud/pmd entry must have been purged
> > by INVLPG.
> 
> OK, now we have implementations which match the naming ;) Again, is a
> cc:stable warranted?

Right. This patch 2/2 fixes the memory leak on x86.

Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")

Patch 1/2 fixes the panic on arm64.

Fixes: 324420bf91f60 ("arm64: add support for ioremap() block mappings")

> Do you have any preferences/suggestions as to which tree these should
> be merged through?  You're hitting core, arm and x86.

No, I do not have any preference.

Thanks,
-Toshi
