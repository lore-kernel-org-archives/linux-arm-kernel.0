From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 28 Feb 2012 15:09:09 +0530
Subject: [PATCH 0/4] twl-regulator DT adaptation and updates to add new
 regulators
Message-ID: <1330421953-29517-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Here is a consolidated series which adds DT support for twl regulator
driver and adds support for VDD1/2/3 regulator and support for
fixed LDO V1V8 and V2V1. The patches are based on -next and tested
on omap3 beagle and omap4 panda boards.

I have dropped the patch updating the dts entries for twl4030 and
twl6030 because of other dependencies and will submit them via
the OMAP tree. The driver DT changes however do not have any dependency
on the dts file updates (except that regulator support will not work with DT,
but will not break DT build or boot) and no functionality would change
in the non-DT case.

regards,
Rajendra

Peter Ujfalusi (2):
  regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
  MFD: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS

Rajendra Nayak (1):
  regulator: twl: adapt twl-regulator driver to dt

Tero Kristo (1):
  regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators

 .../bindings/regulator/twl-regulator.txt           |   68 +++++
 drivers/mfd/twl-core.c                             |   25 ++
 drivers/regulator/twl-regulator.c                  |  294 ++++++++++++++------
 include/linux/i2c/twl.h                            |    7 +-
 4 files changed, 309 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
