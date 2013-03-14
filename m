From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Mar 2013 17:27:33 +0000
Subject: [PATCH 4/4] ARM: at91: introduce SAMA5 support
In-Reply-To: <1363280736-23624-5-git-send-email-ludovic.desroches@atmel.com>
References: <1363280736-23624-1-git-send-email-ludovic.desroches@atmel.com>
 <1363280736-23624-5-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <51420885.60006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/13 17:05, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> This patch introduces the SAMA5 support. It also updates the PMC driver to
> manage clock division which is a requirement since some peripherals can't work
> at the bus frequency on SAMA5.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Tested-by: Robert Nelson <robertcnelson@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                 |    5 +
>  arch/arm/boot/dts/sama5d3.dtsi             | 1031 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/sama5d31ek.dts           |   51 ++
>  arch/arm/boot/dts/sama5d33ek.dts           |   44 ++
>  arch/arm/boot/dts/sama5d34ek.dts           |   61 ++
>  arch/arm/boot/dts/sama5d35ek.dts           |   56 ++
>  arch/arm/boot/dts/sama5d3xcm.dtsi          |   91 +++
>  arch/arm/boot/dts/sama5d3xdm.dtsi          |   42 ++
>  arch/arm/boot/dts/sama5d3xmb.dtsi          |  166 +++++
>  arch/arm/configs/sama5_defconfig           |  181 +++++
>  arch/arm/mach-at91/Kconfig                 |   33 +
>  arch/arm/mach-at91/Makefile                |    4 +
>  arch/arm/mach-at91/board-dt-sama5.c        |   86 +++
>  arch/arm/mach-at91/clock.c                 |  109 ++-
>  arch/arm/mach-at91/clock.h                 |    2 +
>  arch/arm/mach-at91/include/mach/at91_pmc.h |   18 +-
>  arch/arm/mach-at91/include/mach/cpu.h      |   20 +
>  arch/arm/mach-at91/include/mach/sama5d3.h  |   73 ++
>  arch/arm/mach-at91/sama5d3.c               |  377 ++++++++++
>  arch/arm/mach-at91/setup.c                 |   27 +
>  arch/arm/mach-at91/soc.h                   |    5 +
>  21 files changed, 2453 insertions(+), 29 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sama5d3.dtsi
>  create mode 100644 arch/arm/boot/dts/sama5d31ek.dts
>  create mode 100644 arch/arm/boot/dts/sama5d33ek.dts
>  create mode 100644 arch/arm/boot/dts/sama5d34ek.dts
>  create mode 100644 arch/arm/boot/dts/sama5d35ek.dts
>  create mode 100644 arch/arm/boot/dts/sama5d3xcm.dtsi
>  create mode 100644 arch/arm/boot/dts/sama5d3xdm.dtsi
>  create mode 100644 arch/arm/boot/dts/sama5d3xmb.dtsi
>  create mode 100644 arch/arm/configs/sama5_defconfig
>  create mode 100644 arch/arm/mach-at91/board-dt-sama5.c
>  create mode 100644 arch/arm/mach-at91/include/mach/sama5d3.h
>  create mode 100644 arch/arm/mach-at91/sama5d3.c

So I haven't started reviewing this yet, but looking at the diffstat, I
can't help but think this patch could use some splitting to be more
easily reviewable.

How about having one patch for the clock stuff, one for the config, one
for the DT, and finally one for the SoC support itself?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
