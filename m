From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 14 Apr 2014 20:41:18 +0300
Subject: [PATCH v2 0/5] Introduce keystone reset driver
Message-ID: <1397497283-16391-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches introduce keystone reset driver.

The keystone SoC can be rebooted in several ways. By external reset
pin, by soft and by watchdogs. This driver allows software reset or reset
by one of the watchdogs. Also added opportunity to set soft/hard reset type.

Based on v3.15-rc1

v1..v2
	- re basedon on v3.15-rc1 without changes

Ivan Khoronzhuk (5):
  Power: reset: keystone-reset: introduce keystone reset driver
  Power: reset: add bindings for keystone reset driver
  ARM: keystone: remove redundant reset stuff
  ARM: dts: keystone: update reset node to work with reset driver
  ARM: keystone: enable reset driver support

 .../bindings/power/reset/keystone-reset.txt        |  59 +++++++
 arch/arm/boot/dts/keystone.dtsi                    |   4 +-
 arch/arm/configs/keystone_defconfig                |   3 +
 arch/arm/mach-keystone/keystone.c                  |  35 -----
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/keystone-reset.c               | 171 +++++++++++++++++++++
 7 files changed, 244 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/keystone-reset.txt
 create mode 100644 drivers/power/reset/keystone-reset.c

-- 
1.8.3.2
