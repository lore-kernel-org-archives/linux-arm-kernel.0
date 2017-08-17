From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 17 Aug 2017 15:27:25 +0200
Subject: [GIT PULL] arm: mediatek: soc updates for v4.14
Message-ID: <9f782ba3-4c03-10a9-07c5-b2b682f81846@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

for v4.14 please take the following pull request into account.

Thanks,
Matthias

---

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.13-next-soc

for you to fetch changes up to 52510ee934885ec846faaa5d029329c9ba0e6ecc:

   soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC 
(2017-08-14 17:28:40 +0200)

----------------------------------------------------------------
- add mt7623a smp support
- scpsys: reduce code duplication
- scpsys: add mt7622 support
- pmic wrapper: make of_device_ids constant

----------------------------------------------------------------
Arvind Yadav (1):
       soc: mtk-pmic-wrap: make of_device_ids const.

Chen Zhong (1):
       soc: mediatek: add header files required for MT7622 SCPSYS dt-binding

Sean Wang (4):
       ARM: mediatek: add MT7623a smp bringup code
       dt-bindings: soc: update the binding document for SCPSYS on MediaTek 
MT7622 SoC
       soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
       soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC

  .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
  arch/arm/mach-mediatek/mediatek.c                  |   2 +
  arch/arm/mach-mediatek/platsmp.c                   |   1 +
  drivers/soc/mediatek/mtk-pmic-wrap.c               |   6 +-
  drivers/soc/mediatek/mtk-scpsys.c                  | 247 ++++++++++++---------
  include/dt-bindings/power/mt7622-power.h           |  22 ++
  include/linux/soc/mediatek/infracfg.h              |   7 +
  7 files changed, 185 insertions(+), 103 deletions(-)
  create mode 100644 include/dt-bindings/power/mt7622-power.h
