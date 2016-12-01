From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 1 Dec 2016 20:34:04 +0200
Subject: [GIT PULL 1/3] ARM: exynos: Soc/mach for v4.10
In-Reply-To: <1479967709-6619-2-git-send-email-krzk@kernel.org>
References: <1479967709-6619-1-git-send-email-krzk@kernel.org>
 <1479967709-6619-2-git-send-email-krzk@kernel.org>
Message-ID: <20161201183404.GA2134@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 08:08:27AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> This contains previous dts branch because SCU node in dts is needed
> prior to removing it from mach code.
> 
> Below you will find full pull request and one stripped from dependency.
> 

Hi Arnd, Kevin and Olof,

What about this pull from the set?

Best regards,
Krzysztof


> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.10
> 
> for you to fetch changes up to c689de56c0a7c8387ea00509f94fa483ae61d979:
> 
>   ARM: Drop fixed 200 Hz timer requirement from Samsung platforms (2016-11-23 19:34:55 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc update for v4.10:
> 1. Use SCU mapping from Device Tree instead of statically mapped one.
> 2. Drop fixed requirement for HZ=200 on Samsung platforms.
> 
> ----------------------------------------------------------------
> Javier Martinez Canillas (1):
>       ARM: dts: exynos: Document eMMC/SD/SDIO devices in Snow and Peach boards
> 
> Krzysztof Kozlowski (3):
>       ARM: dts: exynos: Remove exynos4415.dtsi
>       Merge tag 'samsung-dt-4.10' into next/soc
>       ARM: Drop fixed 200 Hz timer requirement from Samsung platforms
> 
> Pankaj Dubey (4):
>       ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c
>       ARM: dts: exynos: Add SCU device node to exynos4.dtsi
>       ARM: EXYNOS: Remove static mapping of SCU SFR
>       ARM: EXYNOS: Remove unused soc_is_exynos{4,5}
> 
> Randy Li (2):
>       ARM: dts: exynos: Add TOPEET itop core board SCP package version
>       ARM: dts: exynos: Add TOPEET itop elite based board
> 
> Sylwester Nawrocki (3):
>       ARM: dts: exynos: Remove "simple-bus" compatible from fimc-is node
>       ARM: dts: exynos: Add entries for sound support on Odroid-XU board
>       ARM: S3C24XX: Add DMA slave maps for remaining s3c24xx SoCs
> 
>  .../bindings/arm/samsung/samsung-boards.txt        |   3 +
>  arch/arm/Kconfig                                   |   3 +-
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos4.dtsi                     |   5 +
>  arch/arm/boot/dts/exynos4412-itop-elite.dts        | 240 ++++++++
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 501 ++++++++++++++++
>  arch/arm/boot/dts/exynos4415-pinctrl.dtsi          | 575 ------------------
>  arch/arm/boot/dts/exynos4415.dtsi                  | 650 ---------------------
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   2 +-
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   4 +
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          |  69 +++
>  arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |   9 +
>  arch/arm/boot/dts/exynos5410.dtsi                  |  59 ++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   3 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |   3 +
>  arch/arm/mach-exynos/common.h                      |   6 +-
>  arch/arm/mach-exynos/exynos.c                      |  22 -
>  arch/arm/mach-exynos/include/mach/map.h            |   2 -
>  arch/arm/mach-exynos/platsmp.c                     |  65 +--
>  arch/arm/mach-exynos/pm.c                          |   4 +-
>  arch/arm/mach-exynos/suspend.c                     |   4 +-
>  arch/arm/mach-s3c24xx/common.c                     |  76 +++
>  arch/arm/plat-samsung/include/plat/map-s5p.h       |   4 -
>  23 files changed, 1004 insertions(+), 1306 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos4415-pinctrl.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos4415.dtsi
> 
> 
> Pull request details for Soc only:
> ##################################
> ----------------------------------------------------------------
> Samsung mach/soc update for v4.10:
> 1. Use SCU mapping from Device Tree instead of statically mapped one.
> 2. Drop fixed requirement for HZ=200 on Samsung platforms.
> 
> ----------------------------------------------------------------
> Krzysztof Kozlowski (1):
>       ARM: Drop fixed 200 Hz timer requirement from Samsung platforms
> 
> Pankaj Dubey (3):
>       ARM: EXYNOS: Remove static mapping of SCU SFR
>       ARM: EXYNOS: Remove unused soc_is_exynos{4,5}
>       ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c
> 
> Sylwester Nawrocki (1):
>       ARM: S3C24XX: Add DMA slave maps for remaining s3c24xx SoCs
> 
