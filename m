From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  8 Sep 2014 11:32:59 +0100
Subject: [PATCH v4 0/4]   Add usb phy support for STiH41x SoCs.
Message-ID: <1410172383-17306-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the on-chip PHY used for USB 1.1 and 2.0 found
on STiH415 and STiH416 consumer electronics SoC's from STMicroelectronics.

Changes since v3:
 - Fix copy/paste typo whereby phy is registered twice
 - Remove .owner field, as device is registered using module_platform_driver API

Changes since v2:
 - Rebased on top of 3.17-rc3
 - Enable driver in multi_v7_defconfig

Changes since v1:
 - Change to select GENERIC_PHY rather than depends for uniformity
 - Ensure phy_provider_register is called  after PHY is created
 - Add extra commit message for MAINTAINERS patch

Peter Griffin (4):
  phy: phy-stih41x-usb: Add usb phy support for STiH41x SoCs.
  phy: phy-stih41x-usb: Add dt documentation for USB phy on STiH415/6
  MAINTAINERS: Add phy-stih41x-usb.c to ARCH/STI architecture
  ARM: multi_v7_defconfig: Enable stih41x usb phy driver.

Peter Griffin (4):
  phy: phy-stih41x-usb: Add usb phy support for STiH41x SoCs.
  phy: phy-stih41x-usb: Add dt documentation for USB phy on STiH415/6
  MAINTAINERS: Add phy-stih41x-usb.c to ARCH/STI architecture
  ARM: multi_v7_defconfig: Enable stih41x usb phy driver.

 .../devicetree/bindings/phy/phy-stih41x-usb.txt    |  24 +++
 MAINTAINERS                                        |   1 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-stih41x-usb.c                      | 187 +++++++++++++++++++++
 6 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
 create mode 100644 drivers/phy/phy-stih41x-usb.c

-- 
1.9.1
