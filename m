From: olof@lixom.net (Olof Johansson)
Date: Sun, 30 Sep 2018 12:23:43 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180930192343.erige7yfbrnvil2m@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, Greg,

The following changes since commit a132bb90414bfad4f8ee23cb45fe6946a89b167d:

  Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes (2018-09-08 10:04:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 082dc55e3c5e559b0e6855c0de23ebd674bcc91e:

  ARM: dts: stm32: update SPI6 dmas property on stm32mp157c (2018-09-25 20:39:06 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A handful of fixes that have been coming in the last couple of weeks:

 - Freescale fixes for on-chip accellerators
 - A DT fix for stm32 to avoid fallback to non-DMA SPI mode
 - Fixes for badly specified interrupts on BCM63xx SoCs
 - Allwinner A64 HDMI was incorrectly specified as fully compatble with R40
 - Drive strength fix for SAMA5D2 NAND pins on one board

----------------------------------------------------------------
Alexandre Belloni (1):
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Amelie Delaunay (1):
      ARM: dts: stm32: update SPI6 dmas property on stm32mp157c

Antoine Tenart (1):
      MAINTAINERS: update the Annapurna Labs maintainer email

Florian Fainelli (1):
      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers

Icenowy Zheng (1):
      ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl

Olof Johansson (3):
      Merge tag 'sunxi-fixes-for-4.19-2' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'at91-4.19-fixes' of git://git.kernel.org/.../at91/linux into fixes
      Merge tag 'arm-soc/for-4.19/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

 MAINTAINERS                               |  2 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts |  2 ++
 arch/arm/boot/dts/bcm63138.dtsi           | 14 ++++++++------
 arch/arm/boot/dts/stm32mp157c.dtsi        |  4 ++--
 arch/arm/boot/dts/sun8i-r40.dtsi          |  3 +--
 drivers/soc/fsl/qbman/qman.c              |  3 +++
 drivers/soc/fsl/qe/ucc.c                  |  2 +-
 7 files changed, 18 insertions(+), 12 deletions(-)
