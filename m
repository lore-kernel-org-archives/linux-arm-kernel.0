From: ian@slimlogic.co.uk (Ian Lartey)
Date: Thu, 07 Mar 2013 13:23:47 +0000
Subject: [PATCH v8 0/12] Palmas Updates
In-Reply-To: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <513894E3.1070206@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds to the support for the Palmas iseries of PMIC chips.

Some of the patches have previously been submitted individually.
The DT bindings doc has been added first due to comments that it was 
missing.

Patches based on linux-next-20130306

mfd: DT bindings for the palmas family MFD
mfd: palmas: is_palmas_charger needed by multiple driv
mfd: palmas add variant and OTP detection
regulator: palmas correct dt parsing
watchdog: add Palmas Watchdog support
watchdog: Kconfig for Palmas watchdog
gpio: palmas: add in GPIO support for palmas charger
gpio: palmas: Enable DT support for palmas gpio
leds: Add support for Palmas LEDs
leds: Kconfig for Palmas LEDs
clk: add a clock driver for palmas
clk: Kconfig for Palmas clock driver

  .../devicetree/bindings/clock/palmas-clk.txt       |   25 +
  .../devicetree/bindings/gpio/gpio-palmas.txt       |   21 +
  .../devicetree/bindings/input/palmas-pwrbutton.txt |   22 +
  .../devicetree/bindings/leds/leds-palmas.txt       |   35 ++
  Documentation/devicetree/bindings/mfd/palmas.txt   |   70 +++
  .../devicetree/bindings/regulator/palmas-pmic.txt  |  168 ++++++
  .../devicetree/bindings/rtc/palmas-rtc.txt         |   22 +
  .../devicetree/bindings/watchdog/palmas-wdt.txt    |   22 +
  drivers/clk/Kconfig                                |    8 +
  drivers/clk/Makefile                               |    1 +
  drivers/clk/clk-palmas.c                           |  268 ++++++++++
  drivers/gpio/gpio-palmas.c                         |   90 +++-
  drivers/leds/Kconfig                               |    9 +
  drivers/leds/Makefile                              |    1 +
  drivers/leds/leds-palmas.c                         |  560 
++++++++++++++++++++
  drivers/mfd/palmas.c                               |  103 +++-
  drivers/regulator/palmas-regulator.c               |   36 +-
  drivers/watchdog/Kconfig                           |    8 +
  drivers/watchdog/Makefile                          |    1 +
  drivers/watchdog/palmas_wdt.c                      |  170 ++++++
  include/linux/mfd/palmas.h                         |  119 ++++-
  21 files changed, 1703 insertions(+), 56 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/clock/palmas-clk.txt
  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-palmas.txt
  create mode 100644 
Documentation/devicetree/bindings/input/palmas-pwrbutton.txt
  create mode 100644 Documentation/devicetree/bindings/leds/leds-palmas.txt
  create mode 100644 Documentation/devicetree/bindings/mfd/palmas.txt
  create mode 100644 
Documentation/devicetree/bindings/regulator/palmas-pmic.txt
  create mode 100644 Documentation/devicetree/bindings/rtc/palmas-rtc.txt
  create mode 100644 
Documentation/devicetree/bindings/watchdog/palmas-wdt.txt
  create mode 100644 drivers/clk/clk-palmas.c
  create mode 100644 drivers/leds/leds-palmas.c
  create mode 100644 drivers/watchdog/palmas_wdt.c
