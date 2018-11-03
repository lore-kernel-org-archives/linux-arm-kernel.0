From: olof@lixom.net (Olof Johansson)
Date: Sat, 3 Nov 2018 11:45:28 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181103184528.apzyn447zjk27dat@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 4b42745211af552f170f38a1b97f4a112b5da6b2:

  Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-29 15:37:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 8008cc78d3d6f5191ffcb2b85a423d516000e7f4:

  Merge tag 'omap-for-v4.20/omap1-fix-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-11-02 22:31:40 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A few fixes who have come in near or during the merge window:

 - Removal of a VLA usage in Marvell mpp platform code
 - Enable some IPMI options for ARM64 servers by default, helps testing
 - Enable PREEMPT on 32-bit ARMv7 defconfig
 - Minor fix for stm32 DT (removal of an unused DMA property)
 - Bugfix for TI OMAP1-based ams-delta (-EINVAL -> IRQ_NOTCONNECTED)

----------------------------------------------------------------
Alexandre Torgue (1):
      ARM: dts: stm32: update HASH1 dmas property on stm32mp157c

Arnd Bergmann (1):
      ARM: orion: avoid VLA in orion_mpp_conf

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix impossible .irq < 0

John Garry (1):
      arm64: defconfig: Enable some IPMI configs

Linus Walleij (1):
      ARM: defconfig: Update multi_v7 to use PREEMPT

Marc Zyngier (1):
      soc: ti: QMSS: Fix usage of irq_set_affinity_hint

Olof Johansson (1):
      Merge tag 'omap-for-v4.20/omap1-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

 arch/arm/boot/dts/stm32mp157c.dtsi    |  2 +-
 arch/arm/configs/multi_v7_defconfig   |  1 +
 arch/arm/mach-omap1/board-ams-delta.c |  8 ++------
 arch/arm/plat-orion/mpp.c             |  7 ++++++-
 arch/arm64/configs/defconfig          |  3 +++
 drivers/soc/ti/knav_qmss.h            |  4 ++--
 drivers/soc/ti/knav_qmss_acc.c        | 10 +++++-----
 drivers/soc/ti/knav_qmss_queue.c      | 22 +++++++++++++++-------
 8 files changed, 35 insertions(+), 22 deletions(-)
