From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 20 Aug 2015 11:25:44 +0900
Subject: [GIT PULL v2 0/5] Samsung updates for v4.3
In-Reply-To: <55CCE517.2070003@kernel.org>
References: <55CCE517.2070003@kernel.org>
Message-ID: <023501d0daef$86d21c20$94765460$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Hello Arnd, Olof, Kevin
> 
Hi,

Please pull and if any comments, please kindly let me know.

Thanks,
Kukjin

> Here is re-spin of pull request for Samsung stuff for v4.3 as per Olof's
> suggestion.
> 
> Most of this pull-requests are to switch to support generic cpufreq
> driver for exynos3250, 4210, 4412 and 5250 and several exynos dt updates.
> 
> Note as I commented in each tag, each pull-request(signed tag) has a
> dependency with each other, so please keep the ordering in this time.
> 
> 1) tags/samsung-clk-driver
> 2) tags/samsung-late-dt
> 3) tags/samsung-soc
> 4) tags/samsung-late-cpufreq-driver
> 5) tags/samsung-defconfig-new
> 
> If any problems, please kindly let me know.
> 
> Thanks,
> Kukjin
> 
> Alexis Ballier (1):
>       ARM: dts: enable SPI1 for exynos4412-odroidu3
> 
> Anand Moon (1):
>       ARM: exynos_defconfig: Enable CONFIG_SND_SOC_ODROIDX2 for Odroid-XU3
> 
> Bartlomiej Zolnierkiewicz (5):
>       cpufreq: exynos: remove exynos5250 specific cpufreq driver support
>       clk: exynos4x12: add cpu clock configuration data and instantiate
> cpu clock
>       cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support
>       ARM: dts: add CPU OPP and regulator supply property for exynos4x12
>       ARM: EXYNOS: switch to using generic cpufreq driver for exynos4x12
> 
> Chanho Park (1):
>       ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
> 
> Chanwoo Choi (4):
>       clk: exynos3250: Add cpu clock configuration data and instaniate
> cpu clock
>       ARM: EXYNOS: Add exynos3250 compatible to use generic cpufreq driver
>       ARM: dts: Add CPU OPP and regulator supply property for exynos3250
>       ARM: dts: Add CPU cooling binding for exynos3250 boards
> 
> Javier Martinez Canillas (4):
>       ARM: multi_v7_defconfig: Remove old Samsung USB PHY configs
>       ARM: multi_v7_defconfig: Enable NTC Thermistors support
>       ARM: exynos_defconfig: Enable NTC Thermistors support
>       ARM: multi_v7_defconfig: Enable max77802 regulator
> 
> Jonas Rabenstein (1):
>       cpufreq: exynos: Remove unselectable rule for arm-exynos-cpufreq.o
> 
> Krzysztof Kozlowski (1):
>       ARM: exynos_defconfig: Enable cpufreq-dt driver
> 
> Marek Szyprowski (1):
>       ARM: dts: add iommu property to JPEG device for exynos4
> 
> Michal Suchanek (1):
>       ARM: dts: Add SPI CS on exynos5250-snow
> 
> Thomas Abraham (3):
>       clk: exynos5250: add cpu clock configuration data and instantiate
> cpu clock
>       ARM: EXYNOS: switch to using generic cpufreq driver for exynos5250
>       ARM: dts: add CPU OPP and regulator supply property for exynos5250
> 
>  arch/arm/boot/dts/exynos3250-monk.dts              |  19 ++
>  arch/arm/boot/dts/exynos3250-rinato.dts            |  19 ++
>  arch/arm/boot/dts/exynos3250.dtsi                  |  16 ++
>  arch/arm/boot/dts/exynos4.dtsi                     |   1 +
>  arch/arm/boot/dts/exynos4212.dtsi                  |  81 +++++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   4 +
>  arch/arm/boot/dts/exynos4412-odroidu3.dts          |   8 +
>  arch/arm/boot/dts/exynos4412-origen.dts            |   4 +
>  arch/arm/boot/dts/exynos4412-trats2.dts            |   4 +
>  arch/arm/boot/dts/exynos4412.dtsi                  |  83 ++++++++
>  arch/arm/boot/dts/exynos5250-arndale.dts           |   4 +
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   4 +
>  arch/arm/boot/dts/exynos5250-snow.dts              |   5 +
>  arch/arm/boot/dts/exynos5250-spring.dts            |   4 +
>  arch/arm/boot/dts/exynos5250.dtsi                  |  22 ++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi             |  81 +++++++
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   1 +
>  arch/arm/configs/exynos_defconfig                  |   5 +
>  arch/arm/configs/multi_v7_defconfig                |   5 +-
>  arch/arm/mach-exynos/Kconfig                       |   2 +
>  arch/arm/mach-exynos/exynos.c                      |   4 +
>  drivers/clk/samsung/clk-exynos3250.c               |  32 ++-
>  drivers/clk/samsung/clk-exynos4.c                  |  50 +++++
>  drivers/clk/samsung/clk-exynos5250.c               |  31 +++
>  drivers/cpufreq/Kconfig.arm                        |  49 -----
>  drivers/cpufreq/Makefile                           |   4 -
>  drivers/cpufreq/exynos-cpufreq.c                   | 237
> ---------------------
>  drivers/cpufreq/exynos-cpufreq.h                   |  89 --------
>  drivers/cpufreq/exynos4x12-cpufreq.c               | 236
> --------------------
>  drivers/cpufreq/exynos5250-cpufreq.c               | 210 ------------------
>  include/dt-bindings/clock/exynos3250.h             |   1 +
>  include/dt-bindings/clock/exynos5250.h             |   1 +
>  32 files changed, 487 insertions(+), 829 deletions(-)
