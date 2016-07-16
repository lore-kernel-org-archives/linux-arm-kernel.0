From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 15 Jul 2016 17:18:20 -0700
Subject: [RCF 0/3] hwmon: add driver for TI ADS1118
Message-ID: <cover.1468626668.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new driver for the TI ADS1118 and ADS1018.
It works, and is somewhat based on the work that went into
ads1015, except for the sysfs code, which I hope is more
correct and up to date.

The main reason this is an RFC, rather than a submission
is that I pulled several new dts properies out of the
air, and I would like any thoughts on these in particular.
The code is tested only against ads1118.

If anyone has an ads1018, I'd love to get testing from you
as well.

Joshua Clayton (3):
  hwmon: Add ads1118 driver
  hwmon: Document bindings for ads1118 adc driver
  ARM: imx6q-evi: ads ads1118 support

 .../devicetree/bindings/hwmon/ads1118.txt          |  81 ++++
 arch/arm/boot/dts/imx6q-evi.dts                    |  90 ++++
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/ads1118.c                            | 516 +++++++++++++++++++++
 5 files changed, 699 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ads1118.txt
 create mode 100644 drivers/hwmon/ads1118.c

-- 
2.7.4
