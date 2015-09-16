From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 17 Sep 2015 08:19:48 +0900
Subject: [PATCH v2 0/7] Add support for Exynos SROM Controller driver
In-Reply-To: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <55F9F914.3000709@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/15 17:02, Pankaj Dubey wrote:
> This patch set adds support for Exynos SROM controller DT based driver.
> Currently SROM register sets are used only during S2R, so driver
> basically added for taking care of S2R. It will help us in removing
> static mapping from exynos.c and other extra code handline during S2R.
> 
> This patch set also updated exynos4 and exynos5 dtsi files for with device
> node for srom, and added binding documentation for the same.
> 
> First two patches are some minor cleanup in mach-exynos.
> 
> Patchset v1 was posted here[1]
> [1]: https://lkml.org/lkml/2015/4/29/98
> 
> Changes since v1:
>  - Rebased to latest kgene tree.
>  - Addressed review comments from Krzysztof Kozlowski.
>  - Add two new patches for minor cleanup in exynos.c and map.h
> 
> Pankaj Dubey (7):
>   ARM: EXYNOS: remove unused static mapping of CMU for exynos5
>   ARM: EXYNOS: code cleanup in map.h
>   drivers: soc: add support for exynos SROM driver
>   ARM: EXYNOS: Remove SROM related register settings from mach-exynos
>   ARM: dts: add SROM device node for exynos4
>   ARM: dts: add SROM device node for exynos5
>   Documentation: dt-bindings: add exynos-srom binding information
> 
>  .../bindings/arm/samsung/exynos-srom.txt           |  12 ++
>  arch/arm/boot/dts/exynos4.dtsi                     |   5 +
>  arch/arm/boot/dts/exynos5.dtsi                     |   5 +
>  arch/arm/mach-exynos/Kconfig                       |   2 +
>  arch/arm/mach-exynos/common.h                      |   2 -
>  arch/arm/mach-exynos/exynos.c                      |  22 ----
>  arch/arm/mach-exynos/include/mach/map.h            |   8 --
>  arch/arm/mach-exynos/regs-srom.h                   |  53 --------
>  arch/arm/mach-exynos/suspend.c                     |  20 +--
>  arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/samsung/Kconfig                        |  13 ++
>  drivers/soc/samsung/Makefile                       |   1 +
>  drivers/soc/samsung/exynos-srom.c                  | 143 +++++++++++++++++++++
>  drivers/soc/samsung/exynos-srom.h                  |  51 ++++++++
>  16 files changed, 236 insertions(+), 104 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
>  delete mode 100644 arch/arm/mach-exynos/regs-srom.h
>  create mode 100644 drivers/soc/samsung/Kconfig
>  create mode 100644 drivers/soc/samsung/Makefile
>  create mode 100644 drivers/soc/samsung/exynos-srom.c
>  create mode 100644 drivers/soc/samsung/exynos-srom.h
> 
Hi Pankaj,

Can you please address comments as per Krzysztof's review?...

- Kukjin
