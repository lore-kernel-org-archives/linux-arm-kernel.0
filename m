From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 2 Nov 2016 09:32:54 -0500
Subject: [PATCHv3 0/4] Add Altera A10SR Status & Control Monitor
Message-ID: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

his patch series adds the Altera Arria10 DevKit System Resource
chip's Status and Control Monitor to the A10SR Multi-Function
Device. An earlier patch added this to the hwmon class which
wasn't the proper place so this functionality is added to the
misc directory.
Version 2 changes the DT names from -mon to -monitor for better
readability and clarity and changed the previous version from
modular to built-in.
Version 3 improves the DT bindings naming and removes an unused
variable.

Thor Thayer (4):
  dt-bindings: mfd: Add Altera Arria10 SR Monitor
  misc: Add Altera Arria10 System Resource Control
  mfd: altr-a10sr: Add Arria10 SR Monitor
  ARM: socfpga: dts: Add Monitor to A10-SR MFD

 .../devicetree/bindings/mfd/altera-a10sr.txt       |  11 +-
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |   4 +
 drivers/mfd/altera-a10sr.c                         |   6 +-
 drivers/misc/Kconfig                               |   7 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/altera-a10sr-monitor.c                | 175 +++++++++++++++++++++
 7 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/altera-a10sr-monitor.c

-- 
1.9.1
