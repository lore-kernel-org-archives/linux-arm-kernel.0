From: henryc.chen@mediatek.com (Henry Chen)
Date: Wed, 11 May 2016 17:31:28 +0800
Subject: Add support for regulator operation mode of mt6397 
Message-ID: <1462959090-2877-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators support different operating modes, but there is no suitable
property that can pass the opeation mode constraints on runtime at present.

This series making the change to specify supported modes as a devicetree list.
Consumers can change or get the regulator operation mode by regulator_set_mode
/regulator_get_mode and define the support operating mode on devicetree.

There is a requirement from SVS driver. SVS calibartion requires that the
regulator be in its low-noise (pwm mode) state at boot, but at all other times
it can be normal mode for power saving
http://www.spinics.net/lists/devicetree/msg111204.html

Henry Chen (2):
  regulator: Add support for parsing operation mode
  regulator: mt6397: Add buck change mode regulator interface for mt6397

 .../bindings/regulator/mt6397-regulator.txt        | 22 +++++
 .../devicetree/bindings/regulator/regulator.txt    | 10 +++
 drivers/regulator/mt6397-regulator.c               | 95 +++++++++++++++++++---
 drivers/regulator/of_regulator.c                   | 14 ++++
 4 files changed, 129 insertions(+), 12 deletions(-)

-- 
1.8.1.1.dirty
