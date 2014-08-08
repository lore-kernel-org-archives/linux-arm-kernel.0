From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 8 Aug 2014 16:39:05 +0200
Subject: [PATCH 00/10 v3] Coresight framework and drivers
In-Reply-To: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20140808163905.30f7cb12@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu,

On Thu,  7 Aug 2014 12:21:36 -0600, mathieu.poirier at linaro.org wrote:

>  arch/arm/Kconfig.debug                     |   36 +-
>  arch/arm/boot/dts/omap3-beagle-xm.dts      |   28 +
>  arch/arm/boot/dts/omap3-beagle.dts         |   28 +
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |  199 ++++
>  arch/arm/include/asm/hardware/coresight.h  |  157 ---
>  arch/arm/include/asm/hardware/cp14.h       |  540 ++++++++++
>  arch/arm/kernel/Makefile                   |    1 -
>  arch/arm/kernel/etm.c                      |  654 ------------
>  arch/arm/kernel/hw_breakpoint.c            |    4 +-
>  arch/arm/mach-omap2/Kconfig                |    8 -
>  arch/arm/mach-omap2/Makefile               |    1 -
>  arch/arm/mach-omap2/emu.c                  |   50 -
>  drivers/Makefile                           |    1 +
>  drivers/amba/bus.c                         |    2 +-
>  drivers/coresight/Makefile                 |    9 +
>  drivers/coresight/coresight-etb10.c        |  529 ++++++++++
>  drivers/coresight/coresight-etm-cp14.c     |  506 ++++++++++
>  drivers/coresight/coresight-etm.h          |  192 ++++
>  drivers/coresight/coresight-etm3x.c        | 1516 ++++++++++++++++++++++++++++
>  drivers/coresight/coresight-funnel.c       |  251 +++++
>  drivers/coresight/coresight-priv.h         |   63 ++
>  drivers/coresight/coresight-replicator.c   |  153 +++
>  drivers/coresight/coresight-tmc.c          |  740 ++++++++++++++
>  drivers/coresight/coresight-tpiu.c         |  212 ++++
>  drivers/coresight/coresight.c              |  638 ++++++++++++
>  drivers/coresight/of_coresight.c           |  202 ++++
>  include/linux/amba/bus.h                   |    1 +
>  include/linux/coresight.h                  |  200 ++++

So a brand new framework gets added, and there's nothing added in
Documentation/ ? It'd be nice to have a short documentation that
explains what the framework is defined for, how driver should be
written for it, what is its kernel-space or user-space interface, etc.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
