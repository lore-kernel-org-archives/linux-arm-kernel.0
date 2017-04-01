From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sat,  1 Apr 2017 03:18:47 -0400
Subject: [PATCH v3 0/7] mfd: Add OF device table to I2C drivers that are
 missing it
Message-ID: <20170401071854.23198-1-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series add OF device ID tables to mfd I2C drivers whose devices are
either used in Device Tree source files or are listed in binding docs as
a compatible string.

That's done because the plan is to change the I2C core to report proper OF
modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
a device was registered via DT or using the legacy platform data mechanism.

So these patches will make sure that mfd I2C drivers modules will continue
to be autoloaded once the I2C core is changed to report proper OF modalias.

Users didn't have a vendor prefix in the used compatible strings, but since
there wasn't a DT binding document for these drivers, it can be said that
were working for mere luck and so this series fixes the users and add a DT
binding doc for the drivers.

It's safe to apply the patches independently.

Best regards,
Javier

Changes in v3:
- Add a vendor prefix to the compatible string (Rob Herring).
- Add a vendor prefix to the compatible string (Rob Herring).

Changes in v2:
- Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disabled.
- Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disabled.

Javier Martinez Canillas (7):
  mfd: Add Device Tree bindings document for retu/tahvo ASIC chips
  mfd: retu: Add OF device ID table
  i2c: i2c-cbus-gpio: Add vendor prefix to retu node in example
  ARM: dts: n8x0: Add vendor prefix to retu node
  mfd: Add Device Tree bindings document for TI tps6105x chip
  mfd: tps6105x: Add OF device ID table
  ARM: ux500: Add vendor prefix to tps61052 node

 .../devicetree/bindings/i2c/i2c-cbus-gpio.txt         |  2 +-
 Documentation/devicetree/bindings/mfd/retu.txt        | 19 +++++++++++++++++++
 Documentation/devicetree/bindings/mfd/tps6105x.txt    | 17 +++++++++++++++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi           |  2 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi                 |  2 +-
 drivers/mfd/retu-mfd.c                                |  8 ++++++++
 drivers/mfd/tps6105x.c                                |  8 ++++++++
 7 files changed, 55 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/retu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/tps6105x.txt

-- 
2.9.3
