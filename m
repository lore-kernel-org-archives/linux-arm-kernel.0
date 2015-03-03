From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Mar 2015 16:37:40 +0000
Subject: [RFC PATCH 0/4] make memtest a generic kernel feature
In-Reply-To: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20150303163740.GA10239@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 02:55:41PM +0000, Vladimir Murzin wrote:
> Hi,

Hi Vladimir,
 
> Memtest is a simple feature which fills the memory with a given set of
> patterns and validates memory contents, if bad memory regions is detected it
> reserves them via memblock API. Since memblock API is widely used by other
> architectures this feature can be enabled outside of x86 world.
> 
> This patch set promotes memtest to live under generic mm umbrella and enables
> memtest feature for arm/arm64.
> 
> Patches are built on top of 4.0-rc1

Thanks for putting this together. I've found this extremely useful for
tracking down an issue with some errant DMA on an arm64 platform. For
the first three patches:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> Vladimir Murzin (4):
>   mm: move memtest under /mm
>   memtest: use phys_addr_t for physical addresses
>   arm64: add support for memtest
>   arm: add support for memtest
> 
>  arch/arm/mm/init.c          |    3 ++
>  arch/arm64/mm/init.c        |    2 +
>  arch/x86/Kconfig            |   11 ----
>  arch/x86/include/asm/e820.h |    8 ---
>  arch/x86/mm/Makefile        |    2 -
>  arch/x86/mm/memtest.c       |  118 -------------------------------------------
>  include/linux/memblock.h    |    8 +++
>  lib/Kconfig.debug           |   11 ++++
>  mm/Makefile                 |    1 +
>  mm/memtest.c                |  118 +++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 143 insertions(+), 139 deletions(-)
>  delete mode 100644 arch/x86/mm/memtest.c
>  create mode 100644 mm/memtest.c
> 
> -- 
> 1.7.9.5
> 
