From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 30 Jul 2014 13:22:50 -0500
Subject: [PATCHv9 0/3] Addition of Altera EDAC support.
Message-ID: <1406744573-609-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

The Altera SDRAM controller and EDAC support are added in this
patch series. The SDRAM controller is an MFD so that multiple
drivers can access it's registers.

Thor Thayer (3):
  mfd: altera: Add Altera SDRAM Controller
  edac: altera: Add Altera EDAC support.
  arm: dts: Add Altera SDRAM controller bindings

 .../devicetree/bindings/arm/altera/socfpga-sdr.txt |   13 +
 MAINTAINERS                                        |    6 +
 arch/arm/boot/dts/socfpga.dtsi                     |   10 +
 drivers/edac/Kconfig                               |   10 +
 drivers/edac/Makefile                              |    2 +
 drivers/edac/altera_edac.c                         |  293 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |    7 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/altera-sdr.c                           |  162 +++++++++++
 include/linux/mfd/altera-sdr.h                     |  102 +++++++
 10 files changed, 606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdr.txt
 create mode 100644 drivers/edac/altera_edac.c
 create mode 100644 drivers/mfd/altera-sdr.c
 create mode 100644 include/linux/mfd/altera-sdr.h

-- 
1.7.9.5
