From: clabbe@baylibre.com (Corentin Labbe)
Date: Fri, 13 Jul 2018 11:02:57 +0000
Subject: [PATCH v3 0/9] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patchset add support for allwinner R40 AHCI controller.

This controller need two regulator and one reset which is unsupported
for the moment on ahci_platform.

So this patchset add support for reset and regulator for AHCI
controller.
It add also support for non-target regulator per SATA port.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

Since just before sending this patchset, I discovered the revert of
f0f56716fc3e ("ata: ahci-platform: add reset control support")
I have also tested this serie on a tegra124-jetson-tk1.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (9):
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  ata: ahci_platform: add support for AHCI controller reset
  dt-bindings: ata: ahci-platform: document AHCI reset
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for port regulator
  dt-bindings: ata: ahci-platform: document port-supply
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

 .../devicetree/bindings/ata/ahci-platform.txt      |   7 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  21 +++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  16 ++++
 drivers/ata/ahci.h                                 |   4 +
 drivers/ata/libahci_platform.c                     | 102 ++++++++++++++++++---
 5 files changed, 138 insertions(+), 12 deletions(-)

-- 
2.16.4
