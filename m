From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 10 Apr 2013 22:53:16 +0900
Subject: [GIT PULL v2 3/4] mct-exynos v2 for v3.10
Message-ID: <51656ECC.5070101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull this instead of tags/mct-exynos-for-v3.10 because of wrong 
e-mail address for author. Sorry for that.

Thanks.

- Kukjin
----------------------------------------------------------------

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/mct-exynos-v2-for-v3.10

for you to fetch changes up to 00cf16bc88b4ce15ccd85671e6b0ee54405c32e2:

   clocksource: mct: Add terminating entry for exynos_mct_ids table 
(2013-04-10 17:28:51 +0900)

----------------------------------------------------------------
This adds mct device tree node for all EXYNOS SoCs and moves into 
drivers/clocksource. Note, this is 2nd version because of wrong e-mail 
address for author

----------------------------------------------------------------
Axel Lin (1):
       clocksource: mct: Add terminating entry for exynos_mct_ids table

Doug Anderson (1):
       clocksource: mct: Add missing semicolons in exynos_mct.c

Thomas Abraham (7):
       ARM: EXYNOS: add a register base address variable in mct 
controller driver
       ARM: EXYNOS: prepare an array of MCT interrupt numbers and use it
       ARM: EXYNOS: add device tree support for MCT controller driver
       ARM: EXYNOS: allow dt based discovery of mct controller using 
clocksource_of_init
       ARM: dts: add mct device tree node for all supported Exynos SoC's
       ARM: EXYNOS: remove static io-remapping of mct registers for Exynos5
       ARM: EXYNOS: move mct driver to drivers/clocksource

  .../bindings/timer/samsung,exynos4210-mct.txt      |  68 +++++++
  arch/arm/Kconfig                                   |   2 +-
  arch/arm/boot/dts/exynos4210.dtsi                  |  22 +++
  arch/arm/boot/dts/exynos4212.dtsi                  |  22 +++
  arch/arm/boot/dts/exynos4412.dtsi                  |  24 +++
  arch/arm/boot/dts/exynos5250.dtsi                  |  22 +++
  arch/arm/mach-exynos/Kconfig                       |   8 +-
  arch/arm/mach-exynos/Makefile                      |   2 -
  arch/arm/mach-exynos/common.c                      |   5 -
  arch/arm/mach-exynos/common.h                      |   2 +-
  arch/arm/mach-exynos/include/mach/irqs.h           |   6 -
  arch/arm/mach-exynos/include/mach/map.h            |   1 -
  arch/arm/mach-exynos/include/mach/regs-mct.h       |  53 ------
  arch/arm/mach-exynos/mach-armlex4210.c             |   2 +-
  arch/arm/mach-exynos/mach-exynos4-dt.c             |   3 +-
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   3 +-
  arch/arm/mach-exynos/mach-nuri.c                   |   2 +-
  arch/arm/mach-exynos/mach-origen.c                 |   2 +-
  arch/arm/mach-exynos/mach-smdk4x12.c               |   4 +-
  arch/arm/mach-exynos/mach-smdkv310.c               |   4 +-
  drivers/clocksource/Kconfig                        |   5 +
  drivers/clocksource/Makefile                       |   1 +
  .../mct.c => drivers/clocksource/exynos_mct.c      | 196 
++++++++++++++-------
  23 files changed, 310 insertions(+), 149 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mct.h
  rename arch/arm/mach-exynos/mct.c => drivers/clocksource/exynos_mct.c 
(67%)
