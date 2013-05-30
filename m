From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 30 May 2013 15:51:53 +0200
Subject: [PATCH 0/3] mfd: twl4030-power: Start DT conversion
Message-ID: <1369921916-7435-1-git-send-email-florian.vaussard@epfl.ch>
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

Best regards,

Florian

Florian Vaussard (3):
  mfd: twl4030-power: Split from twl-core into a dedicated module
  mfd: twl4030-power: Start transition to DT
  mfd: twl4030-power: Simplify error path

 .../devicetree/bindings/mfd/twl4030-power.txt      |   28 ++++
 drivers/mfd/twl-core.c                             |   12 +-
 drivers/mfd/twl4030-power.c                        |  149 +++++++++++++++-----
 include/linux/i2c/twl.h                            |    1 -
 4 files changed, 148 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt

-- 
1.7.5.4
