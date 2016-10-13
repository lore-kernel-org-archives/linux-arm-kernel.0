From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 13 Oct 2016 16:32:05 -0500
Subject: [PATCH 0/4] Add Altera A10SR Status & Control Monitor
Message-ID: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch series adds the Altera Arria10 DevKit System Resource
chip's Status and Control Monitor to the A10SR Multi-Function
Device. An earlier patch added this to the hwmon class which
wasn't the proper place so this functionality is added to the
misc directory.

Thor Thayer (4):
  dt-bindings: mfd: Add Altera Arria10 SR Monitor
  misc: Add Altera Arria10 System Resource Control
  mfd: altr-a10sr: Add Arria10 SR Monitor
  ARM: socfpga: dts: Add Monitor to A10-SR MFD

 .../devicetree/bindings/mfd/altera-a10sr.txt       |    9 +
 MAINTAINERS                                        |    1 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |    4 +
 drivers/mfd/altera-a10sr.c                         |    4 +
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/altera-a10sr-mon.c                    |  184 ++++++++++++++++++++
 7 files changed, 210 insertions(+)
 create mode 100644 drivers/misc/altera-a10sr-mon.c

-- 
1.7.9.5
