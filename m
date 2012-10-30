From: monstr@monstr.eu (Michal Simek)
Date: Tue, 30 Oct 2012 12:36:05 +0100
Subject: [PATCH] ARM: zynq: move ttc timer code to drivers/clocksource
In-Reply-To: <20121029185630.GA26149@beefymiracle.amer.corp.natinst.com>
References: <20121029185630.GA26149@beefymiracle.amer.corp.natinst.com>
Message-ID: <508FBBA5.2080707@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2012 07:56 PM, Josh Cartwright wrote:
> Suggested cleanup by Arnd Bergmann.  Move the ttc timer.c code to
> drivers/clocksource, and out of the mach-zynq directory.
>
> The common.h (which only held the timer declaration) was renamed to
> xilinx_ttc.h and moved into include/linux.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/mach-zynq/Makefile      |   2 +-
>   arch/arm/mach-zynq/common.c      |   2 +-
>   arch/arm/mach-zynq/common.h      |  24 ----
>   arch/arm/mach-zynq/timer.c       | 298 ---------------------------------------
>   drivers/clocksource/Makefile     |   1 +
>   drivers/clocksource/xilinx_ttc.c | 297 ++++++++++++++++++++++++++++++++++++++
>   include/linux/xilinx_ttc.h       |  24 ++++
>   7 files changed, 324 insertions(+), 324 deletions(-)
>   delete mode 100644 arch/arm/mach-zynq/common.h
>   delete mode 100644 arch/arm/mach-zynq/timer.c
>   create mode 100644 drivers/clocksource/xilinx_ttc.c
>   create mode 100644 include/linux/xilinx_ttc.h

Really?
If yes. shouldn't be there any better naming convention
especially for headers. linux/clocksource/xilinx_ttc.h.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
