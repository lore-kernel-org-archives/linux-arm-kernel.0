From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 12:43:53 -0700
Subject: [GIT PULL 1/6] ARM: tegra: cleanup for 3.8
Message-ID: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various trivial cleanup changes of the Tegra code for 3.8.

Many of the changes simply remove useless #include statements, which
enable those headers to be removed or moved later, as work towards
multi-platform zImage support.

<mach/{iram,io}map.h> are moved up to arch/arm/mach-tegra to prevent
any new code outside mach-tegra from using them.

Finally, the regulator definitions in all board device tree files are
updated to use the new simpler syntax that was agreed upon.

----------------------------------------------------------------

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.8-cleanup

for you to fetch changes up to bb1de8877c960b3b3e1c8337730df970b262fd44:

  ARM: tegra: move irammap.h to mach-tegra

----------------------------------------------------------------

Stephen Warren (11):
      usb: host: tegra remove include of <mach/iomap.h>
      usb: phy: tegra remove include of <mach/iomap.h>
      ARM: tegra: update *.dts for regulator-compatible deprecation
      crypto: tegra: remove include of <mach/clk.h>
      staging: nvec: remove include of <mach/iomap.h>
      iommu: tegra: remove include of <mach/iomap.h>
      ARM: tegra: remove unnecessary includes of <mach/*.h>
      ARM: tegra: move tegra-ahb.h out of arch/arm/mach-tegra/
      ARM: tegra: remove <mach/dma.h>
      ARM: tegra: move iomap.h to mach-tegra
      ARM: tegra: move irammap.h to mach-tegra

 arch/arm/boot/dts/tegra20-harmony.dts           |   63 +++-------
 arch/arm/boot/dts/tegra20-paz00.dts             |   59 +++------
 arch/arm/boot/dts/tegra20-seaboard.dts          |   59 +++------
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |   63 +++-------
 arch/arm/boot/dts/tegra20-ventana.dts           |   59 +++------
 arch/arm/boot/dts/tegra20-whistler.dts          |  119 +++++-------------
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   47 ++-----
 arch/arm/mach-tegra/apbio.c                     |    5 +-
 arch/arm/mach-tegra/board-dt-tegra20.c          |    4 +-
 arch/arm/mach-tegra/board-dt-tegra30.c          |    3 +-
 arch/arm/mach-tegra/clock.c                     |    2 -
 arch/arm/mach-tegra/common.c                    |    2 +-
 arch/arm/mach-tegra/cpu-tegra.c                 |    3 -
 arch/arm/mach-tegra/cpuidle.c                   |    2 -
 arch/arm/mach-tegra/flowctrl.c                  |    3 +-
 arch/arm/mach-tegra/fuse.c                      |    3 +-
 arch/arm/mach-tegra/headsmp.S                   |    3 +-
 arch/arm/mach-tegra/include/mach/debug-macro.S  |    4 +-
 arch/arm/mach-tegra/include/mach/dma.h          |   54 --------
 arch/arm/mach-tegra/include/mach/powergate.h    |    2 +
 arch/arm/mach-tegra/include/mach/uncompress.h   |    4 +-
 arch/arm/mach-tegra/io.c                        |    2 +-
 arch/arm/mach-tegra/{include/mach => }/iomap.h  |    2 -
 .../arm/mach-tegra/{include/mach => }/irammap.h |    0
 arch/arm/mach-tegra/irq.c                       |    3 +-
 arch/arm/mach-tegra/pcie.c                      |    2 +-
 arch/arm/mach-tegra/platsmp.c                   |    3 +-
 arch/arm/mach-tegra/pmc.c                       |    2 +-
 arch/arm/mach-tegra/powergate.c                 |    2 +-
 arch/arm/mach-tegra/reset.c                     |    5 +-
 arch/arm/mach-tegra/sleep-t20.S                 |    2 -
 arch/arm/mach-tegra/sleep-t30.S                 |    2 -
 arch/arm/mach-tegra/sleep.S                     |    2 +-
 arch/arm/mach-tegra/sleep.h                     |    2 +-
 arch/arm/mach-tegra/tegra20_clocks.c            |    3 +-
 arch/arm/mach-tegra/tegra20_clocks_data.c       |    2 -
 arch/arm/mach-tegra/tegra2_emc.c                |    2 -
 arch/arm/mach-tegra/tegra30_clocks.c            |    3 +-
 arch/arm/mach-tegra/timer.c                     |    2 +-
 drivers/amba/tegra-ahb.c                        |    1 +
 drivers/crypto/tegra-aes.c                      |    2 -
 drivers/iommu/tegra-smmu.c                      |    4 +-
 drivers/staging/nvec/nvec.c                     |    1 -
 drivers/usb/host/ehci-tegra.c                   |    5 +-
 drivers/usb/phy/tegra_usb_phy.c                 |    4 +-
 .../include/mach => include/linux}/tegra-ahb.h  |    6 +-
 sound/soc/tegra/tegra30_ahub.c                  |    1 -
 sound/soc/tegra/tegra_pcm.h                     |    2 -
 48 files changed, 150 insertions(+), 480 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/dma.h
 rename arch/arm/mach-tegra/{include/mach => }/iomap.h (99%)
 rename arch/arm/mach-tegra/{include/mach => }/irammap.h (100%)
 rename {arch/arm/mach-tegra/include/mach => include/linux}/tegra-ahb.h (86%)
