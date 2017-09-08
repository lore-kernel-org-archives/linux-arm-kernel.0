From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  8 Sep 2017 22:02:08 +0900
Subject: [PATCH net-next 0/3] add UniPhier AVE ethernet support
Message-ID: <1504875731-3680-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Socionext AVE ethernet controller implemented
on UniPhier SoCs. This driver supports RGMII/RMII modes.

Furthermore, this series includes support for realtek RTL8201F PHY to be
implemented on some supported boards.

Jassi Brar (1):
  net: phy: realtek: add RTL8201F phy-id and functions

Kunihiko Hayashi (2):
  dt-bindings: net: add DT bindings for Socionext UniPhier AVE
  net: ethernet: socionext: add AVE ethernet driver

 .../bindings/net/socionext,uniphier-ave4.txt       |   44 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/socionext/Kconfig             |   22 +
 drivers/net/ethernet/socionext/Makefile            |    4 +
 drivers/net/ethernet/socionext/sni_ave.c           | 1618 ++++++++++++++++++++
 drivers/net/phy/realtek.c                          |   45 +
 7 files changed, 1735 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
 create mode 100644 drivers/net/ethernet/socionext/Kconfig
 create mode 100644 drivers/net/ethernet/socionext/Makefile
 create mode 100644 drivers/net/ethernet/socionext/sni_ave.c

-- 
2.7.4
