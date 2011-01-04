From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 4 Jan 2011 22:23:59 +0100
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <20110104212359.GH25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Jan 04, 2011 at 08:22:17PM +0000, Russell King - ARM Linux wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/memory.h                  |    2 ++
>  arch/arm/kernel/tcm.c                          |    2 +-
>  arch/arm/mach-aaec2000/include/mach/memory.h   |    2 +-
>  arch/arm/mach-at91/include/mach/memory.h       |    2 +-
>  arch/arm/mach-bcmring/include/mach/hardware.h  |    2 +-
>  arch/arm/mach-bcmring/include/mach/memory.h    |    2 +-
>  arch/arm/mach-clps711x/include/mach/memory.h   |    2 +-
>  arch/arm/mach-cns3xxx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-davinci/include/mach/memory.h    |    4 ++--
>  arch/arm/mach-dove/include/mach/memory.h       |    2 +-
>  arch/arm/mach-ebsa110/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ep93xx/include/mach/memory.h     |   10 +++++-----
>  arch/arm/mach-footbridge/include/mach/memory.h |    2 +-
>  arch/arm/mach-h720x/include/mach/memory.h      |    2 +-
>  arch/arm/mach-integrator/include/mach/memory.h |    2 +-
>  arch/arm/mach-iop13xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-iop32x/include/mach/memory.h     |    2 +-
>  arch/arm/mach-iop33x/include/mach/memory.h     |    2 +-
>  arch/arm/mach-ixp2000/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ixp23xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ixp4xx/include/mach/memory.h     |    2 +-
>  arch/arm/mach-kirkwood/include/mach/memory.h   |    2 +-
>  arch/arm/mach-ks8695/include/mach/memory.h     |    2 +-
>  arch/arm/mach-lh7a40x/include/mach/memory.h    |    2 +-
>  arch/arm/mach-loki/include/mach/memory.h       |    2 +-
>  arch/arm/mach-lpc32xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-mmp/include/mach/memory.h        |    2 +-
>  arch/arm/mach-msm/board-msm7x30.c              |    2 +-
>  arch/arm/mach-msm/include/mach/memory.h        |   10 +++++-----
>  arch/arm/mach-mv78xx0/include/mach/memory.h    |    2 +-
>  arch/arm/mach-mx3/mach-kzm_arm11_01.c          |    2 +-
>  arch/arm/mach-netx/include/mach/memory.h       |    2 +-
>  arch/arm/mach-nomadik/include/mach/memory.h    |    2 +-
>  arch/arm/mach-ns9xxx/include/mach/memory.h     |    2 +-
>  arch/arm/mach-nuc93x/include/mach/memory.h     |    2 +-
>  arch/arm/mach-orion5x/include/mach/memory.h    |    2 +-
>  arch/arm/mach-pnx4008/include/mach/memory.h    |    2 +-
>  arch/arm/mach-pxa/include/mach/memory.h        |    2 +-
>  arch/arm/mach-realview/include/mach/memory.h   |    4 ++--
>  arch/arm/mach-rpc/include/mach/memory.h        |    2 +-
>  arch/arm/mach-s3c2400/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s3c2410/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s3c24a0/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s3c64xx/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5p6442/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5p64x0/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pc100/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pv210/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pv310/include/mach/memory.h    |    2 +-
>  arch/arm/mach-sa1100/include/mach/memory.h     |    2 +-
>  arch/arm/mach-shark/include/mach/memory.h      |    2 +-
>  arch/arm/mach-shmobile/include/mach/memory.h   |    2 +-
>  arch/arm/mach-tegra/include/mach/memory.h      |    2 +-
>  arch/arm/mach-u300/include/mach/memory.h       |    6 +++---
>  arch/arm/mach-u300/u300.c                      |    2 +-
>  arch/arm/mach-ux500/include/mach/memory.h      |    2 +-
>  arch/arm/mach-versatile/include/mach/memory.h  |    2 +-
>  arch/arm/mach-vexpress/include/mach/memory.h   |    2 +-
>  arch/arm/mach-w90x900/include/mach/memory.h    |    2 +-
>  arch/arm/plat-omap/include/plat/memory.h       |    4 ++--
>  arch/arm/plat-spear/include/plat/memory.h      |    2 +-
>  arch/arm/plat-stmp3xxx/include/mach/memory.h   |    2 +-
>  arch/arm/plat-tcc/include/mach/memory.h        |    2 +-
>  63 files changed, 77 insertions(+), 75 deletions(-)
You didn't touch arch/arm/plat-mxc/include/mach/memory.h which defines
PHYS_OFFSET, too.  I assume you just missed these?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
