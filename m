From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Mar 2013 11:27:14 +0100
Subject: [PATCH v3 0/6] introduce support for Atmel Cortex-A5 devices
In-Reply-To: <1363958654-7713-1-git-send-email-ludovic.desroches@atmel.com>
References: <1363958654-7713-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <51517802.40908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 02:24 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Hello,
> 
> Updated set of patches for SAMA5D3 family support, based on
> Jean-Christophe ARM: at91: Kconfig cleanup for prepare add of Cortex-A5 Sama5
> patches.
> 
> v3 changes:
> - put device tree files and defconfig file in separate patches

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I add the series on top of at91-3.10-soc branch.

Thanks.

> v2 changes:
> - remove ARM: at91: fix infinite loop in at91_irq_suspend/resume taken as 3.9
> fix
> - add missing patch: ARM: at91: change name template in AT91_SOC_START macro
> - remove select HAVE_NET_MACB
> 
> Ludovic Desroches (6):
>   ARM: at91: change name template in AT91_SOC_START macro
>   ARM: at91: add AT91_SAM9_TIME entry to select at91sam926x_time.c
>     compilation
>   ARM: at91: introduce the core type choice to split ARMv4/5 and ARMv7
>     arch
>   ARM: at91: introduce SAMA5 support
>   ARM: at91: dt: add device tree files for SAMA5D3 family
>   ARM: at91: add defconfig for SAMA5
> 
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
>  arch/arm/mach-at91/Kconfig                 |   59 +-
>  arch/arm/mach-at91/Makefile                |    7 +-
>  arch/arm/mach-at91/at91rm9200.c            |    2 +-
>  arch/arm/mach-at91/at91sam9260.c           |    2 +-
>  arch/arm/mach-at91/at91sam9261.c           |    2 +-
>  arch/arm/mach-at91/at91sam9263.c           |    2 +-
>  arch/arm/mach-at91/at91sam9g45.c           |    2 +-
>  arch/arm/mach-at91/at91sam9n12.c           |    2 +-
>  arch/arm/mach-at91/at91sam9rl.c            |    2 +-
>  arch/arm/mach-at91/at91sam9x5.c            |    2 +-
>  arch/arm/mach-at91/board-dt-sama5.c        |   86 +++
>  arch/arm/mach-at91/clock.c                 |  109 ++-
>  arch/arm/mach-at91/clock.h                 |    2 +
>  arch/arm/mach-at91/include/mach/at91_pmc.h |   18 +-
>  arch/arm/mach-at91/include/mach/cpu.h      |   20 +
>  arch/arm/mach-at91/include/mach/sama5d3.h  |   73 ++
>  arch/arm/mach-at91/sama5d3.c               |  377 ++++++++++
>  arch/arm/mach-at91/setup.c                 |   27 +
>  arch/arm/mach-at91/soc.h                   |    7 +-
>  29 files changed, 2486 insertions(+), 43 deletions(-)
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
> 


-- 
Nicolas Ferre
