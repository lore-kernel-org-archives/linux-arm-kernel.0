From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 10:28:03 +0000
Subject: [PATCH v4 15/19] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110212102803.GC15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:55:57PM +0000, Catalin Marinas wrote:
>  arch/arm/include/asm/memory.h     |   17 +++++++++--------
>  arch/arm/include/asm/outercache.h |   14 ++++++++------
>  arch/arm/include/asm/pgtable.h    |    2 +-
>  arch/arm/include/asm/setup.h      |    2 +-
>  arch/arm/kernel/setup.c           |    5 +++--
>  arch/arm/mm/init.c                |    6 +++---
>  arch/arm/mm/mmu.c                 |    7 ++++---
>  7 files changed, 29 insertions(+), 24 deletions(-)

If this is split up into four separate patches, we can probably sort out
merging this for the upcoming window.

asm/memory.h will conflict non-trivially with p2v patch set, but I think
we can merge the changes to everything but __virt_to_phys/__phys_to_virt.

asm/outercache.h changes are stand-alone.

asm/pgtable.h looks like it could use __pfn_to_phys(pfn) rather than
adding the cast, and can be combined with mm/init.c and mm/mmu.c.

asm/setup.h and arch/arm/kernel/setup.c form another logical group.
