From: david.hernandezsanchez@st.com (David HERNANDEZ SANCHEZ)
Date: Fri, 5 Oct 2018 10:08:44 +0000
Subject: [PATCH 0/3] Introduce STM32 thermal driver
Message-ID: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STMicroelectronics Digital Temperature
Sensor (DTS), used on some STM32 SoCs.

Driver is based on thermal sysfs and it has been tested OK on a 4.19-rc5 linux
release.

Please feel free to contact me back for further information
and to discuss about this implementation.

Br,
David HERNANDEZ SANCHEZ

David Hernandez Sanchez (3):
  dt-bindings: stm32-thermal: add binding documentation
  thermal: add stm32 thermal driver
  ARM: dts: stm32: add thermal sensor support on STM32MP157c

 .../devicetree/bindings/thermal/stm32-thermal.txt  |  61 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  35 +
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/st/Kconfig                         |  14 +
 drivers/thermal/st/Makefile                        |   1 +
 drivers/thermal/st/stm_thermal.c                   | 760 +++++++++++++++++++++
 7 files changed, 873 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/stm32-thermal.txt
 create mode 100644 drivers/thermal/st/stm_thermal.c

--
2.7.4
