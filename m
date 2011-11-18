From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 18 Nov 2011 16:47:16 +0530
Subject: [PATCH v5 0/4] Device tree support for regulators
Message-ID: <1321615040-13257-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v5 is based on 3.2-rc2 and has the following changes
-1- Used microvolt/microamp in bindings instead of uV/uA
-2- Added more documentation surrounding regulator-consumer
mapping in the core bindings
-3- Dropped CONFIG_OF_REGULATOR and use just CONFIG_OF
-4- Reused core regulator bindings on Fixed regulator bindings
-5- Corrected the gpio binding for Fixed regulator

The patches can be found here:
git://gitorious.org/omap-pm/linux.git for-dt/regulator

For the first 2 patches (1/4 and 2/4) I have dropped
Acks from Mark, since they have changed to some extent
from the last post and retained the Acks recieved on the
last 2 patches (3/4 and 4/4) as they remain unchanged.

regards,
Rajendra

Rajendra Nayak (4):
  regulator: helper routine to extract regulator_init_data
  regulator: adapt fixed regulator driver to dt
  regulator: pass additional of_node to regulator_register()
  regulator: map consumer regulator based on device tree

 .../bindings/regulator/fixed-regulator.txt         |   29 +++++++
 .../devicetree/bindings/regulator/regulator.txt    |   54 +++++++++++++
 drivers/regulator/88pm8607.c                       |    2 +-
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/aat2870-regulator.c              |    2 +-
 drivers/regulator/ab3100.c                         |    2 +-
 drivers/regulator/ab8500.c                         |    2 +-
 drivers/regulator/ad5398.c                         |    2 +-
 drivers/regulator/bq24022.c                        |    2 +-
 drivers/regulator/core.c                           |   82 ++++++++++++++++---
 drivers/regulator/da903x.c                         |    2 +-
 drivers/regulator/db8500-prcmu.c                   |    2 +-
 drivers/regulator/dummy.c                          |    2 +-
 drivers/regulator/fixed.c                          |   62 +++++++++++++++-
 drivers/regulator/isl6271a-regulator.c             |    2 +-
 drivers/regulator/lp3971.c                         |    2 +-
 drivers/regulator/lp3972.c                         |    2 +-
 drivers/regulator/max1586.c                        |    2 +-
 drivers/regulator/max8649.c                        |    2 +-
 drivers/regulator/max8660.c                        |    2 +-
 drivers/regulator/max8925-regulator.c              |    2 +-
 drivers/regulator/max8952.c                        |    2 +-
 drivers/regulator/max8997.c                        |    2 +-
 drivers/regulator/max8998.c                        |    2 +-
 drivers/regulator/mc13783-regulator.c              |    2 +-
 drivers/regulator/mc13892-regulator.c              |    2 +-
 drivers/regulator/of_regulator.c                   |   81 +++++++++++++++++++
 drivers/regulator/pcap-regulator.c                 |    2 +-
 drivers/regulator/pcf50633-regulator.c             |    2 +-
 drivers/regulator/tps6105x-regulator.c             |    3 +-
 drivers/regulator/tps65023-regulator.c             |    2 +-
 drivers/regulator/tps6507x-regulator.c             |    2 +-
 drivers/regulator/tps6524x-regulator.c             |    2 +-
 drivers/regulator/tps6586x-regulator.c             |    2 +-
 drivers/regulator/tps65910-regulator.c             |    2 +-
 drivers/regulator/tps65912-regulator.c             |    2 +-
 drivers/regulator/twl-regulator.c                  |    2 +-
 drivers/regulator/wm831x-dcdc.c                    |    8 +-
 drivers/regulator/wm831x-isink.c                   |    2 +-
 drivers/regulator/wm831x-ldo.c                     |    6 +-
 drivers/regulator/wm8350-regulator.c               |    2 +-
 drivers/regulator/wm8400-regulator.c               |    2 +-
 drivers/regulator/wm8994-regulator.c               |    2 +-
 include/linux/regulator/driver.h                   |    4 +-
 include/linux/regulator/of_regulator.h             |   20 +++++
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 46 files changed, 362 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h
