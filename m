From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 19:26:06 +0800
Subject: [PATCH v2 0/2] Add Combo PHY driver for HiSilicon STB SoCs
Message-ID: <1508757968-22729-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds device tree bindings and driver support for Combo PHY device
which can be found on HiSilicon STB SoCs.

Changes for v2:
 - Move DT bindings into a separate patch.
 - Drop the spurious newline from drivers/phy/Makefile.
 - Use the phy type defines in dt-bindings/phy/phy.h.
 - Use PTR_ERR_OR_ZERO() for checking return from
   devm_of_phy_provider_register().
 - Add USB3 phy support.

Jianguo Sun (2):
  dt-bindings: add bindings doc for hi3798cv200 combphy
  phy: add combo phy driver for HiSilicon STB SoCs

 .../bindings/phy/phy-hi3798cv200-combphy.txt       |  19 ++
 drivers/phy/hisilicon/Kconfig                      |   9 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-histb-combphy.c          | 253 +++++++++++++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
 create mode 100644 drivers/phy/hisilicon/phy-histb-combphy.c

-- 
1.9.1
