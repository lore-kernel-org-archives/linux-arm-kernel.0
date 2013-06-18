From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 18 Jun 2013 15:17:55 +0200
Subject: [PATCH v2 0/5] mfd: twl4030-power: Start DT conversion and updates
Message-ID: <1371561480-28325-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series enables a partial DT support for twl4030-power. The
missing part is the power management scripts, as the required
binding should be defined first. It however enables the complete
shutdown of the processor at poweroff when booting with DT,
dropping the power consumption from around 350 mA on Overo+Tobi
to about 40 mA.

The poweroff callback was tested with both DT and non-DT boots.

The last two patches simplify the error path in the probe function,
and fix registers relocking on error.

Best regards,

Florian

Since v1:
- use module_platform_driver()
- split the refactoring of the probe function into a dedicated patch
- new patch to fix registers relocking on error
- rebased on mfd-next


Florian Vaussard (5):
  mfd: twl4030-power: Split from twl-core into a dedicated module
  mfd: twl4030-power: Simplify probing of power scripts and resources
  mfd: twl4030-power: Start transition to DT
  mfd: twl4030-power: Simplify error path
  mfd: twl4030-power: Fix relocking on error

 .../devicetree/bindings/mfd/twl4030-power.txt      |   28 ++++
 drivers/mfd/twl-core.c                             |   12 +-
 drivers/mfd/twl4030-power.c                        |  149 ++++++++++++++-----
 include/linux/i2c/twl.h                            |    1 -
 4 files changed, 146 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt

-- 
1.7.5.4
