From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 09:41:15 +0000
Subject: [PATCH] ARM: EXYNOS: Fix build error which was from common.c
 and old cpu.c
In-Reply-To: <01a001ccce6d$d9f3ea60$8ddbbf20$%kim@samsung.com>
References: <01a001ccce6d$d9f3ea60$8ddbbf20$%kim@samsung.com>
Message-ID: <20120109094115.GF21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 10:27:27AM +0900, Kukjin Kim wrote:
> This fixes build error and wrong merge conflicts.
> arch/arm/mach-exynos/common.c: In function 'exynos4_gic_irq_fix_base':
> arch/arm/mach-exynos/common.c:393: error: dereferencing pointer to incomplete type
> arch/arm/mach-exynos/common.c:396: error: dereferencing pointer to incomplete type
> 
> Following A and B have been created from different base and the build
> error was casued in the process of merging and should be fixed in this
> merge window.
> 
> A. commit db0d4db ("ARM: gic: allow GIC to support non-banked setups"),
>   commit 4e44d2c ("ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER")
>   and commit 69676c3 ("ARM: exynos4: Fix build error due to
>   'gic_bank_offset' undeclared")
> 
> B. commit cc511b8 ("ARM: 7257/1: EXYNOS: introduce arch/arm/mach-exynos/
>   common.[ch]") introduced common.[ch]")

Well, git isn't that good at telling you what conflicts on a delete/modify
conflict - all it does is leave you the modified file in the tree and
expect you to know what changes were made to it between the version which
was deleted, and the modified version.

The various git diff combinations really don't help you either - all you
get told by git is that the file is 'unmerged' and that's it.

I'd say these are the kind of merges which are always going to be full of
errors - and I doubt there's anything which can really be done to stop
them being so (unless git starts marking the file with merge conflict
markers for those changes I describe above.)
