From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 May 2012 20:50:31 +0900
Subject: [PATCH 00/20] ARM: Samsung: Add support for Exynos5250 Rev1.0
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <019701cd2dd9$ef5cec50$ce16c4f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> This patch series adds support for Samsung's Exynos5250 Rev1.0. It
> includes
> fixes for device tree support, updates for rev1.0 silicon and device tree
> discovery for combiner and wakeup interrupt controller. This patch series
> depricates the existing support for Exynos5250 Rev0.0.
> 
> This patchset is based and tested on top of v3.4-rc5.
> 
> Boojin Kim (1):
>   ARM: EXYNOS: Support DMA for EXYNOS5250 SoC
> 
> Changhwan Youn (2):
>   ARM: EXYNOS: Modify the GIC physical address for static io-mapping
>   ARM: EXYNOS: Redefine IRQ_MCT_L0,1 definition
> 
> Kisoo Yu (1):
>   ARM: EXYNOS: Add pre-divider and fout mux clocks for bpll and mpll
> 
> Kukjin Kim (2):
>   ARM: EXYNOS: fix ctrlbit for exynos5_clk_pdma1
>   ARM: EXYNOS: update irqs for EXYNOS5250 evt1
> 
> Sangsu Park (1):
>   ARM: EXYNOS: add GPC4 bank instance
> 
> Thomas Abraham (13):
>   ARM: EXYNOS: Add watchdog timer clock instance
>   ARM: Exynos: Remove a new bus_type instance for Exynos5
>   of/irq: fix interrupt parent lookup procedure
>   of/irq: add retry support for interrupt controller tree initialization
>   ARM: Exynos: Add irq_domain support for interrupt combiner
>   ARM: Exynos: Add device tree support for interrupt combiner
>   ARM: Exynos: Simplify the wakeup interrupt setup code
>   ARM: Exynos: Add irq_domain support for gpio wakeup interrupts
>   ARM: Exynos: Remove arch_initcall for wakeup interrupt initialization
>   ARM: Exynos: Add device tree support for gpio wakeup interrupt
> controller
>   ARM: dts: Update device tree source files for EXYNOS5250
>   ARM: Exynos5: Add combiner, wakeup interrupt controller and ethernet
> nodes
>   ARM: Exynos5: Add AUXDATA for i2c controllers
> 
>  .../bindings/arm/samsung/interrupt-combiner.txt    |   52 +++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   63 ++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |   99 ++++--
>  arch/arm/mach-exynos/Kconfig                       |    7 +-
>  arch/arm/mach-exynos/Makefile                      |    2 +-
>  arch/arm/mach-exynos/clock-exynos5.c               |   80 +++++-
>  arch/arm/mach-exynos/common.c                      |  338
++++++++++++++------
>  arch/arm/mach-exynos/dma.c                         |  129 +++++++--
>  arch/arm/mach-exynos/include/mach/gpio.h           |    9 +-
>  arch/arm/mach-exynos/include/mach/irqs.h           |   40 ++-
>  arch/arm/mach-exynos/include/mach/map.h            |    4 +-
>  arch/arm/mach-exynos/include/mach/regs-clock.h     |    2 +
>  arch/arm/mach-exynos/include/mach/regs-gpio.h      |    4 +-
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    4 +
>  arch/arm/mach-exynos/mct.c                         |   17 +-
>  arch/arm/mach-exynos/pm.c                          |    2 +-
>  arch/arm/plat-s5p/clock.c                          |   11 -
>  arch/arm/plat-samsung/Kconfig                      |    2 +-
>  arch/arm/plat-samsung/include/plat/cpu.h           |    2 +-
>  arch/arm/plat-samsung/include/plat/dma-pl330.h     |    1 +
>  drivers/gpio/gpio-samsung.c                        |   11 +-
>  drivers/of/irq.c                                   |   29 ++-
>  22 files changed, 698 insertions(+), 210 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
> 
> --
> 1.7.5.4

Hi,

Basically, it's ok to me on 1st~9th patches except #7 as I commented. Will
apply them but need to update #7. And I will look at the others again. If
any comments, let you know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
