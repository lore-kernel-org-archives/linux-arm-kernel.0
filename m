From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Apr 2014 11:15:14 -0300
Subject: [PATCH 0/6] thermal: Add Armada 375 SoC support
Message-ID: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the support for the thermal sensor in the recently
introduced Armada 375 SoC.

The first three patches are preparation work. They add a generic
infrastructure that allows to support similar thermal sensors in
a non-intrusive way.

Patch four uses the infrastructure to support the Armada 375 SoC
thermal sensor.

Since there are some issues in the Z1 SoC thermal sensor, patch five
adds a quirk to workaround such issues. The Z1 stepping is detected
and the compatible string is updated, so the driver can perform
a special sensor initialization. Also, the quirk moves the offset of
the thermal control register, and allows to specifiy the correct
(A0 stepping) offset in the devicetree.

This quirk is applied only for the A375-DB board, being the only
board with the problematic Z1 SoC.

Finally, the last patch enables the thermal sensor in the devicetree.
for the Armada 375 A0 stepping SoC.

The series applies on v3.15-rc1, and has been tested on A375-DB board and
A370-RD board.

Feedback and comments are welcome!

Ezequiel Garcia (6):
  thermal: armada: Rename armada_thermal_ops struct
  thermal: armada: Add infrastructure to support generic formulas
  thermal: armada: Add generic infrastructure to handle the sensor
  thermal: armada: Support Armada 375 SoC
  ARM: mvebu: Add thermal quirk for the Armada 375 DB board
  ARM: mvebu: Enable the thermal sensor in Armada 375 SoC

 .../devicetree/bindings/thermal/armada-thermal.txt |   7 ++
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +
 arch/arm/mach-mvebu/board-v7.c                     |  57 +++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |   3 +
 drivers/thermal/armada_thermal.c                   | 140 ++++++++++++++++++---
 5 files changed, 197 insertions(+), 16 deletions(-)

-- 
1.9.1
