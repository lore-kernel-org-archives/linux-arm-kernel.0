From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 22 May 2018 13:21:46 +0200
Subject: [PATCH RFC V2 0/6] hwmon: Add support for Raspberry Pi voltage sensor
Message-ID: <1526988112-4021-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common issue for the Raspberry Pi is an inadequate power supply. 
Noralf Tr?nnes started a discussion [1] about writing such undervoltage
conditions into the kernel log.

This series is a draft to upstream the resulting kernel patch and is not
intended for 4.18.

Changes in V2:
- simplified Kconfig dependency suggested by Robin Murphy
- replace dt-binding by probing from firmware driver
- add hwmon documentation
- minor improvements suggested by Guenter Roeck

[1] - https://github.com/raspberrypi/linux/issues/2367

Stefan Wahren (6):
  ARM: bcm2835: Add GET_THROTTLED firmware property
  hwmon: Add support for RPi voltage sensor
  firmware: raspberrypi: Register hwmon driver
  ARM: bcm2835_defconfig: Enable RPi voltage sensor
  ARM: multi_v7_defconfig: Enable RPi voltage sensor
  arm64: defconfig: Enable RPi voltage sensor

 Documentation/hwmon/raspberrypi-hwmon      |  22 ++++
 arch/arm/configs/bcm2835_defconfig         |   2 +-
 arch/arm/configs/multi_v7_defconfig        |   1 +
 arch/arm64/configs/defconfig               |   1 +
 drivers/firmware/raspberrypi.c             |  19 ++++
 drivers/hwmon/Kconfig                      |  10 ++
 drivers/hwmon/Makefile                     |   1 +
 drivers/hwmon/raspberrypi-hwmon.c          | 168 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |   1 +
 9 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hwmon/raspberrypi-hwmon
 create mode 100644 drivers/hwmon/raspberrypi-hwmon.c

-- 
2.7.4
