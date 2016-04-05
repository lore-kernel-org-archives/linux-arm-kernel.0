From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 5 Apr 2016 13:59:28 +0800
Subject: [PATCH v3 00/14] use of_platform_default_populate() to populate
 default bus
Message-ID: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Then it is possible for driver code build as a module, and no
need to export of_default_bus_match_table anymore.

This patchset is based on Linux 4.6-rc2.

Changes since v2:
- Add more acks
- Update based on v4.6-rc2, of-generic.c in sh and board-artpec6.c in arm
  are considered

Changes since v1:
- Add ack, test and review
- Remove v1 patch 14/15, the similar patch has posted and applied,
  see https://patchwork.kernel.org/patch/8096991/

v1:
- https://lkml.org/lkml/2016/1/26/1123

Kefeng Wang (14):
  arm: use of_platform_default_populate() to populate default bus
  arm64: use of_platform_default_populate() to populate default bus
  mips: use of_platform_default_populate() to populate default bus
  c6x: use of_platform_default_populate() to populate default bus
  metag: use of_platform_default_populate() to populate default bus
  cris: use of_platform_default_populate() to populate default bus
  nios2: use of_platform_default_populate() to populate default bus
  xtensa: use of_platform_default_populate() to populate default bus
  sh: use of_platform_default_populate() to populate default bus
  bus: imx-weim: use of_platform_default_populate() to populate default
    bus
  bus: uniphier-system-bus: use of_platform_default_populate() to
    populate default bus
  memory: omap-gpmc: use of_platform_default_populate() to populate
    default bus
  of: unittest: use of_platform_default_populate() to populate default
    bus
  Revert "of/platform: export of_default_bus_match_table"

 arch/arm/kernel/setup.c                  | 3 +--
 arch/arm/mach-artpec/board-artpec6.c     | 2 +-
 arch/arm/mach-at91/at91rm9200.c          | 2 +-
 arch/arm/mach-at91/at91sam9.c            | 2 +-
 arch/arm/mach-at91/sama5.c               | 2 +-
 arch/arm/mach-bcm/board_bcm21664.c       | 2 +-
 arch/arm/mach-bcm/board_bcm281xx.c       | 2 +-
 arch/arm/mach-bcm/board_bcm2835.c        | 5 ++---
 arch/arm/mach-cns3xxx/core.c             | 3 +--
 arch/arm/mach-davinci/da8xx-dt.c         | 3 +--
 arch/arm/mach-exynos/exynos.c            | 2 +-
 arch/arm/mach-highbank/highbank.c        | 2 +-
 arch/arm/mach-imx/imx27-dt.c             | 2 +-
 arch/arm/mach-imx/mach-imx51.c           | 2 +-
 arch/arm/mach-imx/mach-imx53.c           | 2 +-
 arch/arm/mach-imx/mach-imx6q.c           | 2 +-
 arch/arm/mach-imx/mach-imx6sl.c          | 2 +-
 arch/arm/mach-imx/mach-imx6sx.c          | 2 +-
 arch/arm/mach-imx/mach-imx6ul.c          | 2 +-
 arch/arm/mach-imx/mach-imx7d.c           | 2 +-
 arch/arm/mach-integrator/integrator_ap.c | 3 +--
 arch/arm/mach-integrator/integrator_cp.c | 3 +--
 arch/arm/mach-keystone/keystone.c        | 2 +-
 arch/arm/mach-lpc32xx/phy3250.c          | 3 +--
 arch/arm/mach-mvebu/board-v7.c           | 2 +-
 arch/arm/mach-mvebu/dove.c               | 2 +-
 arch/arm/mach-mvebu/kirkwood.c           | 2 +-
 arch/arm/mach-mxs/mach-mxs.c             | 3 +--
 arch/arm/mach-nspire/nspire.c            | 3 +--
 arch/arm/mach-orion5x/board-dt.c         | 3 +--
 arch/arm/mach-picoxcell/common.c         | 2 +-
 arch/arm/mach-rockchip/rockchip.c        | 2 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c  | 2 +-
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c  | 2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c   | 3 +--
 arch/arm/mach-shmobile/setup-sh73a0.c    | 2 +-
 arch/arm/mach-spear/spear1310.c          | 2 +-
 arch/arm/mach-spear/spear1340.c          | 2 +-
 arch/arm/mach-spear/spear300.c           | 3 +--
 arch/arm/mach-spear/spear310.c           | 3 +--
 arch/arm/mach-spear/spear320.c           | 3 +--
 arch/arm/mach-spear/spear6xx.c           | 3 +--
 arch/arm/mach-tegra/tegra.c              | 2 +-
 arch/arm/mach-u300/core.c                | 3 +--
 arch/arm/mach-versatile/versatile_dt.c   | 3 +--
 arch/arm/mach-vt8500/vt8500.c            | 2 +-
 arch/arm/mach-zynq/common.c              | 2 +-
 arch/arm64/kernel/setup.c                | 3 +--
 arch/c6x/platforms/platform.c            | 2 +-
 arch/cris/kernel/setup.c                 | 2 +-
 arch/metag/kernel/setup.c                | 3 +--
 arch/mips/ath79/setup.c                  | 2 +-
 arch/mips/jz4740/setup.c                 | 2 +-
 arch/mips/mti-sead3/sead3-setup.c        | 2 +-
 arch/mips/pic32/pic32mzda/init.c         | 3 +--
 arch/mips/pistachio/init.c               | 2 +-
 arch/mips/xilfpga/init.c                 | 2 +-
 arch/nios2/platform/platform.c           | 3 +--
 arch/sh/boards/of-generic.c              | 3 +--
 arch/xtensa/kernel/setup.c               | 2 +-
 drivers/bus/imx-weim.c                   | 5 ++---
 drivers/bus/uniphier-system-bus.c        | 3 +--
 drivers/memory/omap-gpmc.c               | 3 +--
 drivers/of/platform.c                    | 1 -
 drivers/of/unittest.c                    | 5 ++---
 65 files changed, 67 insertions(+), 94 deletions(-)

-- 
2.6.0.GIT
