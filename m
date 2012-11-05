From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2012 12:22:55 +0100
Subject: [PATCH 2/8] ARM: zynq: move ttc timer code to drivers/clocksource
In-Reply-To: <c0347788fbad559a249a25128a23f40c85d9cbda.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <c0347788fbad559a249a25128a23f40c85d9cbda.1351721190.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3d++0fGSw7GQHcc-S1X1Qh-rfekpr-E8Jkg2_vFqdCFFTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/29 Josh Cartwright <josh.cartwright@ni.com>:
> Suggested cleanup by Arnd Bergmann.  Move the ttc timer.c code to
> drivers/clocksource, and out of the mach-zynq directory.
>
> The common.h (which only held the timer declaration) was renamed to
> xilinx_ttc.h and moved into include/linux.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-zynq/Makefile                                    | 2 +-
>  arch/arm/mach-zynq/common.c                                    | 2 +-
>  drivers/clocksource/Makefile                                   | 1 +
>  arch/arm/mach-zynq/timer.c => drivers/clocksource/xilinx_ttc.c | 1 -
>  arch/arm/mach-zynq/common.h => include/linux/xilinx_ttc.h      | 4 ++--
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/arm/mach-zynq/timer.c => drivers/clocksource/xilinx_ttc.c (99%)
>  rename arch/arm/mach-zynq/common.h => include/linux/xilinx_ttc.h (91%)

Not going to apply this patch till there is clean way how to move all
drivers there.
Especially I don't like to add xilinx_ttc.h to include/linux folder.

Thanks,
Michal
