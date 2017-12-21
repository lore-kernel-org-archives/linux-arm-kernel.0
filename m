From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 Dec 2017 12:48:48 +0100
Subject: [GIT PULL v2] arm: Updates for soc driver for v4.15-next
Message-ID: <5e11ef1f-fe9d-61c6-abe4-44ba4c99e060@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Hi Olof,

Please take the following patches into account.

Thanks a lot,
Matthias

---
The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
tags/v4.15-next-soc

for you to fetch changes up to fdac5f4d4857d488fcd77308fec95b44196fdfb1:

  Merge remote-tracking branch 'mainline-kernel/v4.15-next/pdids' into
v4.15-next/soc (2017-12-21 11:49:33 +0100)

----------------------------------------------------------------
- change kconfig entry for armv7 SoCs to be more generic
- add support for mt2701 scpsys driver
  binding documentation
  extend driver to allow the bus protection to overwrite the register

----------------------------------------------------------------
Matthias Brugger (1):
      Merge remote-tracking branch 'mainline-kernel/v4.15-next/pdids' into
v4.15-next/soc

Sean Wang (1):
      ARM: mediatek: use more generic prompts for SoCs with ARMv7

weiyi.lu at mediatek.com (4):
      dt-bindings: soc: add MT2712 power dt-bindings
      soc: mediatek: extend bus protection API
      soc: mediatek: add dependent clock jpgdec/audio for scpsys
      soc: mediatek: add MT2712 scpsys support

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
 arch/arm/mach-mediatek/Kconfig                     |   2 +-
 drivers/soc/mediatek/mtk-infracfg.c                |  26 +++-
 drivers/soc/mediatek/mtk-scpsys.c                  | 140 ++++++++++++++++++---
 include/dt-bindings/power/mt2712-power.h           |  26 ++++
 include/linux/soc/mediatek/infracfg.h              |   7 +-
 6 files changed, 181 insertions(+), 23 deletions(-)
 create mode 100644 include/dt-bindings/power/mt2712-power.h
