From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:37 -0800
Subject: [GIT PULL 4/9] ARM: SoC platform updates for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates for new platform support:

- New platform: Tango4 from Sigma Designs.
- Broadcom BCM2836 (Raspberry Pi 2 SoC)
- Enable cpufreq on Freescale i.MX7D
- Rockchip: SMP support for rk3036, general support for rk3228
- SMP support on Broadcom Kona and NSP
- Cleanups for OMAP removing legacy IOMMU data

+ a bunch of misc fixes and tweaks for various platforms.


Conflicts:

arch/arm/mach-exynos/Kconfig: Add/add. Keep both.

----------------------------------------------------------------

The following changes since commit d6e3b31e8a51f63d7991dc08bfbcf37c1518cd09:

  Merge branch 'next/multiplatform' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to d6bd05794f18673097ec5e62e577754649a5c632:

  ARM: tango: Fix UP build issues

----------------------------------------------------------------

Aaro Koskinen (1):
      ARM: OMAP: RX-51: fix a typo in log writing

Alim Akhtar (5):
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos3250
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos4
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5410
      ARM: EXYNOS: Switch to syscon reboot and poweroff

Arnd Bergmann (6):
      Merge tag 'arm-soc/for-4.5/soc' of http://github.com/Broadcom/stblinux into next/soc
      ARM: imx: select SRC for i.MX7
      Merge tag 'omap-for-v4.5/81xx-soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge branch 'depends/usb-fixes' into next/soc
      Merge tag 'bcm2835-soc-next-2015-12-28' of http://github.com/anholt/linux into next/soc
      ARM: tango: pass ARM arch level for smc.S

Bai Ping (1):
      ARM: imx: enable cpufreq device on i.mx7d

Colin Ian King (1):
      ARM: mach-imx: iomux-imx31: fix spelling mistake in error message

Eric Anholt (3):
      dt-bindings: Add root properties for Raspberry Pi 2
      ARM: bcm2835: Add a compat string for bcm2836 machine probe
      ARM: bcm2835: Add Kconfig support for bcm2836

Franklin S Cooper Jr (1):
      ARM: omap4: hwmod: Remove elm address space from hwmod data

Hauke Mehrtens (1):
      ARM: BCM5310X: activate erratas needed for SoC

Heiko Stuebner (2):
      ARM: rockchip: add support smp for rk3036
      ARM: rockchip: use const and __initconst for rk3036 smp_operations

J.D. Schroeder (1):
      ARM: DRA7: hwmod: Enable DEBUG_LL for UART4

Jeffy Chen (1):
      ARM: rockchip: enable support for RK3228 SoCs

Jon Mason (1):
      ARM: BCM: Add SMP support for Broadcom 4708

Kapil Hali (2):
      ARM: BCM: Clean up SMP support for Broadcom Kona
      ARM: BCM: Add SMP support for Broadcom NSP

Krzysztof Kozlowski (2):
      Merge tag 'samsung-dt-syscon-restart-4.5' into next/soc
      ARM: EXYNOS: Constify local exynos_pmu_data structure

Lucas Stach (1):
      ARM: BCM5301X: remove workaround imprecise abort fault handler

Marc Gonzalez (2):
      ARM: tango4: Initial platform support
      ARM: tango: Fix UP build issues

Masahiro Yamada (1):
      ARM: uniphier: select PINCTRL

Moritz Fischer (1):
      ARM: zynq: Select ARCH_HAS_RESET_CONTROLLER

Neil Armstrong (3):
      ARM: OMAP: dmtimer: Add clock source from DT
      ARM: OMAP: add DT support for ti,dm816-timer
      ARM: OMAP2+: Add hwmod spinbox support for dm816x

Nicolas Pitre (1):
      mach-imx/mach-imx6ul.c: proper constness with __initconst

Olof Johansson (6):
      Merge tag 'samsung-soc-4.5' of https://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'zynq-soc-for-4.5' of https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'v4.5-rockchip-soc-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge branch 'treewide/cleanup' into next/soc
      Merge tag 'omap-for-v4.5/soc-initcall' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'imx-soc-4.5' of git://git.kernel.org/.../shawnguo/linux into next/soc

Pankaj Dubey (1):
      ARM: EXYNOS: Remove redundant code from regs-pmu.h

Peter Ujfalusi (2):
      ARM: OMAP1: Remove device creation for omap-pcm-audio
      ARM: OMAP2+: Remove device creation for omap-pcm-audio

Suman Anna (6):
      ARM: OMAP2+: Remove legacy device instantiation of IOMMUs
      ARM: OMAP3: hwmod data: Remove legacy IOMMU data
      ARM: OMAP4: hwmod data: Remove legacy IOMMU attr and addrs
      ARM: OMAP2+: Remove omap_mmu_dev_attr structure
      ARM: OMAP: dmtimer: check for fixed timers during config
      ARM: OMAP2+: timer: Remove secure timer for DRA7xx HS devices

Tony Lindgren (6):
      ARM: OMAP2+: Change core_initcall levels to postcore_initcall
      Merge branch 'omap-for-v4.5/initcall' into omap-for-v4.5/soc-v2
      ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
      ARM: OMAP2+: Update 81xx clock and power domains for default, active and sgx
      ARM: OMAP2+: Add mmc hwmod entries for dm814x
      ARM: OMAP2+: Add support for dm814x and dra62x usb


 .../bindings/arm/bcm/brcm,bcm2835.txt           |   4 +
 Documentation/devicetree/bindings/arm/cpus.txt  |   1 +
 MAINTAINERS                                     |   7 +
 arch/arm/Kconfig                                |   2 +
 arch/arm/Kconfig.debug                          |  10 +-
 arch/arm/Makefile                               |   1 +
 arch/arm/boot/dts/bcm11351.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm21664.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm4708.dtsi                  |   2 +
 arch/arm/boot/dts/exynos3250.dtsi               |  14 ++
 arch/arm/boot/dts/exynos4.dtsi                  |  14 ++
 arch/arm/boot/dts/exynos5.dtsi                  |  14 ++
 arch/arm/boot/dts/exynos5410.dtsi               |  14 ++
 arch/arm/mach-bcm/Kconfig                       |  16 +-
 arch/arm/mach-bcm/Makefile                      |  11 +-
 arch/arm/mach-bcm/bcm_5301x.c                   |  35 ----
 arch/arm/mach-bcm/board_bcm2835.c               |   5 +
 arch/arm/mach-bcm/{kona_smp.c => platsmp.c}     | 144 ++++++++++++----
 arch/arm/mach-exynos/Kconfig                    |   3 +
 arch/arm/mach-exynos/pmu.c                      |  45 +----
 arch/arm/mach-exynos/regs-pmu.h                 |   9 -
 arch/arm/mach-imx/Kconfig                       |   1 +
 arch/arm/mach-imx/iomux-imx31.c                 |   2 +-
 arch/arm/mach-imx/mach-imx6ul.c                 |   2 +-
 arch/arm/mach-imx/mach-imx7d.c                  |   6 +
 arch/arm/mach-omap1/devices.c                   |  19 ---
 arch/arm/mach-omap2/Makefile                    |   2 -
 arch/arm/mach-omap2/board-rx51-peripherals.c    |   2 +-
 arch/arm/mach-omap2/clockdomains81xx_data.c     |  29 ++--
 arch/arm/mach-omap2/cm81xx.h                    |   6 +-
 arch/arm/mach-omap2/devices.c                   |  25 +--
 arch/arm/mach-omap2/id.c                        |   4 +-
 arch/arm/mach-omap2/omap-iommu.c                |  66 --------
 arch/arm/mach-omap2/omap2-restart.c             |   2 +-
 arch/arm/mach-omap2/omap_device.c               |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c                |   2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |  42 -----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |  41 -----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |   2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      | 166 ++++++++++++++++---
 arch/arm/mach-omap2/pdata-quirks.c              |   2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c     |  10 +-
 arch/arm/mach-omap2/serial.c                    |   2 +-
 arch/arm/mach-omap2/timer.c                     |   6 +-
 arch/arm/mach-rockchip/platsmp.c                |  45 +++--
 arch/arm/mach-rockchip/rockchip.c               |   1 +
 arch/arm/mach-tango/Kconfig                     |  12 ++
 arch/arm/mach-tango/Makefile                    |   5 +
 arch/arm/mach-tango/platsmp.c                   |  16 ++
 arch/arm/mach-tango/setup.c                     |  17 ++
 arch/arm/mach-tango/smc.S                       |   9 +
 arch/arm/mach-tango/smc.h                       |   5 +
 arch/arm/mach-uniphier/Kconfig                  |   1 +
 arch/arm/mach-zynq/Kconfig                      |   1 +
 arch/arm/plat-omap/dmtimer.c                    |  42 ++++-
 include/linux/platform_data/iommu-omap.h        |   9 -
 56 files changed, 568 insertions(+), 391 deletions(-)
 rename arch/arm/mach-bcm/{kona_smp.c => platsmp.c} (63%)
 delete mode 100644 arch/arm/mach-omap2/omap-iommu.c
 create mode 100644 arch/arm/mach-tango/Kconfig
 create mode 100644 arch/arm/mach-tango/Makefile
 create mode 100644 arch/arm/mach-tango/platsmp.c
 create mode 100644 arch/arm/mach-tango/setup.c
 create mode 100644 arch/arm/mach-tango/smc.S
 create mode 100644 arch/arm/mach-tango/smc.h
