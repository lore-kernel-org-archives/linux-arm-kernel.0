From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Sep 2018 12:01:52 +0200
Subject: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add support for allwinner R40 AHCI controller.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

Patchs 1-7 should go via the ata tree
Patchs 8,9 should go via the sunxi tree

Changes since v4:
- dropped PHY dedicated driver
- added the optionnal phy-supply

Changes since v3:
- Moved PHY code to a new sun4i-a10-phy-sata driver
- Removed reset code since ahci_platform support now reset controller.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (9):
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  ata: ahci_platform: add support for PHY controller regulator
  dt-bindings: ata: ahci-platform: document phy-supply
  ata: ahci_sunxi: add support for r40
  dt-bindings: ata: update ahci_sunxi bindings
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

 .../devicetree/bindings/ata/ahci-platform.txt      |  6 ++-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 18 +++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 13 ++++++
 drivers/ata/ahci.h                                 |  2 +
 drivers/ata/ahci_sunxi.c                           |  3 +-
 drivers/ata/libahci_platform.c                     | 46 +++++++++++++++++++++-
 6 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.16.4
