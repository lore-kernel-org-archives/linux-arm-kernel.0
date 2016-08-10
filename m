From: j-keerthy@ti.com (Keerthy)
Date: Wed, 10 Aug 2016 18:22:20 +0530
Subject: [PATCH v7 0/5] The series cleans up mainly the regulator driver and
 implements
Message-ID: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the patch removes redundant read wrapper and makes
use of regmap_read wherever necessary.

The series is checked for all the regulator registrations on
am437x-gp-evm.

Boot log: http://pastebin.ubuntu.com/22905402/

The series is based on linux-next on top of series titled:
[PATCH v3 0/2] regulator: Enable suspend configuration

Do not have the link of the above series available at the moment.

Changes in v7:

Rebasing to latest next branch. GPIO patch of this series
pushed to linux-next by Linus. Hence posting the remaining
patches with respective Acks from the domain Maintainers.

Changes in v6:

Rebased regulator/mfd clean up patches against linux-next +
https://lkml.org/lkml/2016/6/24/122 series.

Changes in v5:

Rebased regulator clean up patch against linux-next.

Changes in v4:

For gpio-tps65218 reatined the compatible table.
Fixed missing ';' in the power button patch.
Fixed comments on the Documentation patch.
Split the Device Tree patches to a separate series.

Changes in v3:

Missed making corresponding changes in the power button and gpio
drivers. Added couple of patches to fix them to use mfd_cell way
of parsing.

Keerthy (5):
  mfd: tps65218: Remove redundant read wrapper
  Documentation: regulator: tps65218: Update examples
  input: tps65218-pwrbutton: Add platform_device_id table
  mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
  regulator: tps65218: Remove all the compatibles

 .../devicetree/bindings/regulator/tps65218.txt     |  87 +++++++++---
 drivers/gpio/gpio-tps65218.c                       |   3 +-
 drivers/input/misc/tps65218-pwrbutton.c            |  10 +-
 drivers/mfd/tps65218.c                             |  34 ++---
 drivers/regulator/tps65218-regulator.c             | 153 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   3 +-
 6 files changed, 158 insertions(+), 132 deletions(-)

-- 
1.9.1
