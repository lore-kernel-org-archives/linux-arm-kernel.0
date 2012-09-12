From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 12 Sep 2012 08:42:09 +0200
Subject: [PATCH v3 0/8] i2c: at91: cleanup and dt support
Message-ID: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches is based on Nikolaus at91_i2c driver.

Changes:
v3:
  - only put multi-drive lines in the if...else statement (suggested
  by Warner Losh)
v2:
  - change driver name from xxx_i2c to i2c-xxx
  - keep i2c-gpio nodes in dtsi files
  - don't enable TWI on boards whose TWI IP doesn't support clock
  stretching in tranmission mode

Ludovic Desroches (8):
  i2c: at91: use managed resources
  i2c: at91: add warning about transmission issues for some devices
  i2c: at91: use an id table for SoC dependent parameters
  ARM: at91: do not configure at91sam9g10 twi pio as open-drain
  i2c: at91: add dt support to i2c-at91
  ARM: at91: add clocks for I2C DT entries
  ARM: dts: add twi nodes for atmel SoCs
  ARM: dts: add twi nodes for atmel boards

 .../devicetree/bindings/i2c/atmel-i2c.txt          |  30 +++
 arch/arm/boot/dts/at91sam9260.dtsi                 |  10 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |  10 +
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |  12 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  20 ++
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   8 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  20 ++
 arch/arm/boot/dts/at91sam9n12ek.dts                |   8 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  30 +++
 arch/arm/mach-at91/at91rm9200.c                    |   2 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |  11 +-
 arch/arm/mach-at91/at91sam9260.c                   |   4 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |   8 +-
 arch/arm/mach-at91/at91sam9261.c                   |   3 +-
 arch/arm/mach-at91/at91sam9261_devices.c           |  23 +--
 arch/arm/mach-at91/at91sam9263.c                   |   3 +-
 arch/arm/mach-at91/at91sam9263_devices.c           |   2 +-
 arch/arm/mach-at91/at91sam9g45.c                   |   6 +-
 arch/arm/mach-at91/at91sam9g45_devices.c           |   4 +-
 arch/arm/mach-at91/at91sam9n12.c                   |   2 +
 arch/arm/mach-at91/at91sam9rl.c                    |   4 +-
 arch/arm/mach-at91/at91sam9rl_devices.c            |   2 +-
 arch/arm/mach-at91/at91sam9x5.c                    |   6 +-
 drivers/i2c/busses/Kconfig                         |   6 +
 drivers/i2c/busses/i2c-at91.c                      | 217 +++++++++++++--------
 26 files changed, 338 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/atmel-i2c.txt

-- 
1.7.11.3
