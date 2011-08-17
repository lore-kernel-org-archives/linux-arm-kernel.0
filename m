From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 17 Aug 2011 11:28:12 +0530
Subject: [RFC: PATCH 0/4] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <1313058630-32447-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
	<1313058630-32447-1-git-send-email-hvaibhav@ti.com>
Message-ID: <19F8576C6E063C45BE387C64729E739404E3BC9690@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, August 11, 2011 4:00 PM
> To: linux-omap at vger.kernel.org
> Cc: tony at atomide.com; Hilman, Kevin; paul at pwsan.com; linux-arm-
> kernel at lists.infradead.org; Hiremath, Vaibhav
> Subject: [RFC: PATCH 0/4] Introducing TI's New SoC/board AM335XEVM
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
> 
> AM335X is treated as another OMAP3 variant where the
> cpu class is considered as OMAP34XX and the type is AM335X.
> Also, AM335X devices shares similar architecture as TI81XX devices;
> this means, cpu_is_omap34xx(), cpu_is_ti81xx() and
> cpu_is_am335x() checks return success for AM335X.
> 
> Currently submitting this patch series as a RFC, to initiate the
> discussion on the approach we have chosen for AM335x device support.
> Based on the feedback, will submit the final version of patch series
> immediately.
[Hiremath, Vaibhav] Tony/Kevin/Paul and others,

Any comments/inputs/suggestions on this patch series?

Thanks,
Vaibhav


> 
> This patch series is created on top of linux-omap/master and
> Hemant's TI814X patches submitted recently.
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg53457.html
> 
> Also, I have validated OMAP3 boot test with this patch-series on OMAP3EVM.
> 
> Afzal Mohammed (4):
>   AM335X: Update common omap platform files
>   AM335X: Update common OMAP machine specific sources
>   AM335X: Create board support and enable build for AM335XEVM
>   AM335X: Add low level debugging support
> 
>  arch/arm/mach-omap2/Kconfig                    |    7 +++-
>  arch/arm/mach-omap2/Makefile                   |    2 +
>  arch/arm/mach-omap2/board-am335xevm.c          |   57
> ++++++++++++++++++++++++
>  arch/arm/mach-omap2/clock3xxx_data.c           |    3 +
>  arch/arm/mach-omap2/common.c                   |   16 +++++++
>  arch/arm/mach-omap2/id.c                       |    6 +++
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   21 +++++++++
>  arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
>  arch/arm/plat-omap/include/plat/clock.h        |    1 +
>  arch/arm/plat-omap/include/plat/cpu.h          |   14 ++++++
>  arch/arm/plat-omap/include/plat/io.h           |   12 +++++
>  arch/arm/plat-omap/include/plat/omap34xx.h     |    2 +
>  arch/arm/plat-omap/include/plat/serial.h       |    4 ++
>  arch/arm/plat-omap/include/plat/ti81xx.h       |    4 ++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 +++
>  15 files changed, 155 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am335xevm.c
