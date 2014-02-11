From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 12:33:12 +0900
Subject: [PATCHv3 2/2] arm: Get rid of meminfo
In-Reply-To: <1392153265-14439-3-git-send-email-lauraa@codeaurora.org>
References: <1392153265-14439-1-git-send-email-lauraa@codeaurora.org>
 <1392153265-14439-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <52F999F8.8070808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/14 06:14, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
>
> Acked-by: Jason Cooper<jason@lakedaemon.net>
> Acked-by: Catalin Marinas<catalin.marinas@arm.com>
> Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Tested-by: Leif Lindholm<leif.lindholm@linaro.org>
> Signed-off-by: Laura Abbott<lauraa@codeaurora.org>
> ---
>   arch/arm/include/asm/mach/arch.h         |    4 +-
>   arch/arm/include/asm/memblock.h          |    3 +-
>   arch/arm/include/asm/setup.h             |   23 ------
>   arch/arm/kernel/atags_parse.c            |    5 +-
>   arch/arm/kernel/devtree.c                |    5 --
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
>   arch/arm/mach-pxa/spitz.c                |    8 +--
>   arch/arm/mach-pxa/tosa.c                 |    8 +--
>   arch/arm/mach-realview/core.c            |   11 +--
>   arch/arm/mach-realview/core.h            |    3 +-
>   arch/arm/mach-realview/realview_pb1176.c |    8 +--
>   arch/arm/mach-realview/realview_pbx.c    |   17 ++---
>   arch/arm/mach-s3c24xx/mach-smdk2413.c    |    8 +--
>   arch/arm/mach-s3c24xx/mach-vstms.c       |    8 +--

For s3c24xx,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

>   arch/arm/mach-sa1100/assabet.c           |    2 +-
>   arch/arm/mm/init.c                       |   67 +++++++-----------
>   arch/arm/mm/mmu.c                        |  115 +++++++++---------------------
>   33 files changed, 136 insertions(+), 291 deletions(-)

Thanks,
Kukjin
