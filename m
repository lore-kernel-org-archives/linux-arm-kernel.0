From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed,  5 Sep 2018 18:49:43 +0900
Subject: [PATCH 0/2] add new UniPhier PCIe PHY driver
Message-ID: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for PCIe PHY interface implemented in Socionext
UniPhier SoCs. This driver supports LD20 and PXs3 SoCs.

This series contains changes to phy/Kconfig and phy/Makefile, and will conflict
with the preceding PHY patches for USB [1]. Either one needs to rebase itself
later.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597430.html

Kunihiko Hayashi (2):
  dt-bindings: phy: add UniPhier PCIe PHY description
  phy: socionext: add PCIe PHY driver support

 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |  31 +++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/socionext/Kconfig                      |  12 ++
 drivers/phy/socionext/Makefile                     |   6 +
 drivers/phy/socionext/phy-uniphier-pcie.c          | 240 +++++++++++++++++++++
 6 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-pcie.c

-- 
2.7.4
