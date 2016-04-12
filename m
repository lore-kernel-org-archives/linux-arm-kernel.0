From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Apr 2016 16:16:39 +0100
Subject: [PATCH 0/5] Add st-flashss vsense regulator driver
Message-ID: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

This series adds a small regulator driver to manage the voltage regulator
inside the ST flash subsystem found on stih407 based silicon, and it is
used for configuring the eMMC, NAND and SPI voltages (although only
currently utilised for eMMC).

regards,

Peter.

Peter Griffin (5):
  regulator: st-flashss: Add DT binding documentation for flashss
    regulator.
  regulator: st-flashss: Add a regulator driver for flashss vsense.
  MAINTAINERS: Add st-flashss driver to STi section.
  ARM: multi_v7_defconfig: Enable flashss regulator driver.
  ARM: STi: DT: STiH407: Add the flashss voltage regulator DT node.

 .../devicetree/bindings/regulator/st-flashss.txt   |  43 ++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  12 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |   4 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   2 +-
 drivers/regulator/st-flashss.c                     | 274 +++++++++++++++++++++
 8 files changed, 343 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/st-flashss.txt
 create mode 100644 drivers/regulator/st-flashss.c

-- 
1.9.1
