From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 11 Feb 2014 10:47:54 +0100
Subject: [PATCHv2 2/2] arm: Get rid of meminfo
In-Reply-To: <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
References: <1391558551-31395-1-git-send-email-lauraa@codeaurora.org>
 <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <52F9F1CA.2070501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-02-05 01:02, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

This patch fails with SPARSEMEM enabled (tested with v3.14-rc1, 
exynos4_defconfig + oldnoconfig):

arch/arm/mm/init.c: In function ?free_unused_memmap?:
arch/arm/mm/init.c:442:10: error: ?prev_bank_end? undeclared (first use 
in this function)
arch/arm/mm/init.c:442:10: note: each undeclared identifier is reported 
only once for each function it appears in
make[1]: *** [arch/arm/mm/init.o] Error 1
make[1]: *** Waiting for unfinished jobs....


> ---
>   arch/arm/include/asm/mach/arch.h         |    4 +-
>   arch/arm/include/asm/memblock.h          |    3 +-
>   arch/arm/include/asm/setup.h             |   23 ------
>   arch/arm/kernel/atags_parse.c            |    5 +-
>   arch/arm/kernel/setup.c                  |   30 ++------
>   arch/arm/mach-clps711x/board-clep7312.c  |    7 +-
>   arch/arm/mach-clps711x/board-edb7211.c   |   10 +--
>   arch/arm/mach-clps711x/board-p720t.c     |    2 +-
>   arch/arm/mach-footbridge/cats-hw.c       |    2 +-
>   arch/arm/mach-footbridge/netwinder-hw.c  |    2 +-
>   arch/arm/mach-msm/board-halibut.c        |    6 --
>   arch/arm/mach-msm/board-mahimahi.c       |   13 +---
>   arch/arm/mach-msm/board-msm7x30.c        |    3 +-
>   arch/arm/mach-msm/board-sapphire.c       |   13 ++--
>   arch/arm/mach-msm/board-trout.c          |    8 +--
>   arch/arm/mach-orion5x/common.c           |    3 +-
>   arch/arm/mach-orion5x/common.h           |    3 +-
>   arch/arm/mach-pxa/cm-x300.c              |    3 +-
>   arch/arm/mach-pxa/corgi.c                |   10 +--
>   arch/arm/mach-pxa/eseries.c              |    9 +--
>   arch/arm/mach-pxa/poodle.c               |    8 +--
>   arch/arm/mach-pxa/spitz.c                |    9 +--
>   arch/arm/mach-pxa/tosa.c                 |    8 +--
>   arch/arm/mach-realview/core.c            |   11 +--
>   arch/arm/mach-realview/core.h            |    3 +-
>   arch/arm/mach-realview/realview_pb1176.c |    8 +--
>   arch/arm/mach-realview/realview_pbx.c    |   17 ++---
>   arch/arm/mach-s3c24xx/mach-smdk2413.c    |    8 +--
>   arch/arm/mach-s3c24xx/mach-vstms.c       |    8 +--
>   arch/arm/mach-sa1100/assabet.c           |    2 +-
>   arch/arm/mm/init.c                       |   61 ++++++----------
>   arch/arm/mm/mmu.c                        |  115 +++++++++---------------------
>   32 files changed, 133 insertions(+), 284 deletions(-)

(snipped)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
