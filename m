From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 23 May 2016 15:13:28 +0800
Subject: Add support for regulator operation mode of mt6397
Message-ID: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators support different operating modes, but there is no suitable
property that can pass the opeation mode constraints on runtime at present.

This series making the change to specify supported modes as a devicetree list.
Consumers can change or get the regulator operation mode by regulator_set_mode
/regulator_get_mode and define the support operating mode on devicetree.

There is a requirement from SVS driver. SVS calibartion requires that the
regulator be in its low-noise (pwm mode) state at boot, but at all other times
it can be normal mode for power saving.
http://www.spinics.net/lists/devicetree/msg111204.html

Changes in v2:
- Separate patch for binding document changes.
- Create a header to define operation mode on dt-bindings.
- Remove the property "regulator-supported-modes".

Henry Chen (3):
  regulator: DT: Add DT property for operation mode configuration
  regulator: of: Add support for parsing operation mode
  regulator: mt6397: Add buck change mode regulator interface for mt6397

 .../devicetree/bindings/regulator/regulator.txt    |  5 ++
 drivers/regulator/mt6397-regulator.c               | 89 +++++++++++++++++++---
 drivers/regulator/of_regulator.c                   | 15 +++-
 include/dt-bindings/regulator/regulator.h          | 14 ++++
 4 files changed, 113 insertions(+), 10 deletions(-)
 create mode 100644 include/dt-bindings/regulator/regulator.h

-- 
1.8.1.1.dirty
