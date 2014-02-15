From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 12:01:30 +0100
Subject: [PATCH v2 0/4] DT support for kirkwood based Synology NAS boxes
Message-ID: <1392462094-25097-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for around 30 kirkwood bases Synology NAS
boxes. Patch #1 generalized the qnap power off driver so that i can
also be used for Synology devices. Patch #2 and #3 document vendor
prefixes and i2c trivial devices. Patch #4 adds the synology DT files.

v2:
Typo fix in qnap-poweroff.c
Use ricoy stock ticker instead of ricoh
Describe the lego structure of the hardware

Andrew Lunn (4):
  Power: Reset: Generalize qnap-poweroff to with on Synology devices.
  DT: Vender prefixes: Add ricoh, ssi and synology
  DT: i2c: Trivial: Add sii,s35390a, fix ricoh vendor prefix
  ARM: Kirkwood: Add support for many Synology NAS devices

 .../devicetree/bindings/i2c/trivial-devices.txt    |   3 +-
 .../bindings/power_supply/qnap-poweroff.txt        |   5 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |  15 +++
 arch/arm/boot/dts/kirkwood-ds109.dts               |  33 ++++++
 arch/arm/boot/dts/kirkwood-ds110jv10.dts           |  33 ++++++
 arch/arm/boot/dts/kirkwood-ds111.dts               |  33 ++++++
 arch/arm/boot/dts/kirkwood-ds112.dts               |  34 +++++++
 arch/arm/boot/dts/kirkwood-ds209.dts               |  33 ++++++
 arch/arm/boot/dts/kirkwood-ds210.dts               |  35 +++++++
 arch/arm/boot/dts/kirkwood-ds212.dts               |  37 +++++++
 arch/arm/boot/dts/kirkwood-ds212j.dts              |  34 +++++++
 arch/arm/boot/dts/kirkwood-ds409.dts               |  34 +++++++
 arch/arm/boot/dts/kirkwood-ds409slim.dts           |  32 ++++++
 arch/arm/boot/dts/kirkwood-ds411.dts               |  35 +++++++
 arch/arm/boot/dts/kirkwood-ds411j.dts              |  34 +++++++
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |  34 +++++++
 arch/arm/boot/dts/kirkwood-rs212.dts               |  34 +++++++
 arch/arm/boot/dts/kirkwood-rs409.dts               |  33 ++++++
 arch/arm/boot/dts/kirkwood-rs411.dts               |  34 +++++++
 arch/arm/boot/dts/synology/alarm-led-12.dtsi       |  28 ++++++
 arch/arm/boot/dts/synology/common.dtsi             | 112 +++++++++++++++++++++
 arch/arm/boot/dts/synology/ethernet-1.dtsi         |  15 +++
 arch/arm/boot/dts/synology/fan-alarm-18.dtsi       |  22 ++++
 arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi     |  22 ++++
 arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi     |  32 ++++++
 arch/arm/boot/dts/synology/fan-gpios-15.dtsi       |  34 +++++++
 arch/arm/boot/dts/synology/fan-gpios-32.dtsi       |  34 +++++++
 arch/arm/boot/dts/synology/fan-speed-100.dtsi      |  20 ++++
 arch/arm/boot/dts/synology/fan-speed-120.dtsi      |  20 ++++
 arch/arm/boot/dts/synology/fan-speed-150.dtsi      |  20 ++++
 arch/arm/boot/dts/synology/hdd-leds-20.dtsi        |  90 +++++++++++++++++
 arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi      |  36 +++++++
 arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi      |  52 ++++++++++
 arch/arm/boot/dts/synology/hdd-leds-36.dtsi        | 103 +++++++++++++++++++
 arch/arm/boot/dts/synology/hdd-leds-38.dtsi        |  52 ++++++++++
 arch/arm/boot/dts/synology/hdd-power-29.dtsi       |  56 +++++++++++
 arch/arm/boot/dts/synology/hdd-power-30-1.dtsi     |  40 ++++++++
 arch/arm/boot/dts/synology/hdd-power-30-2.dtsi     |  56 +++++++++++
 arch/arm/boot/dts/synology/hdd-power-30-4.dtsi     |  89 ++++++++++++++++
 arch/arm/boot/dts/synology/hdd-power-31.dtsi       |  40 ++++++++
 arch/arm/boot/dts/synology/hdd-power-34.dtsi       |  73 ++++++++++++++
 arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi      |  18 ++++
 arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi      |  18 ++++
 arch/arm/boot/dts/synology/pcie-2.dtsi             |  19 ++++
 drivers/power/reset/qnap-poweroff.c                |  46 +++++++--
 46 files changed, 1703 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
 create mode 100644 arch/arm/boot/dts/synology/alarm-led-12.dtsi
 create mode 100644 arch/arm/boot/dts/synology/common.dtsi
 create mode 100644 arch/arm/boot/dts/synology/ethernet-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-alarm-18.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-gpios-15.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-gpios-32.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-speed-100.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-speed-120.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-speed-150.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-20.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-36.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-38.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-29.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-2.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-4.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-31.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-34.dtsi
 create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi
 create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi
 create mode 100644 arch/arm/boot/dts/synology/pcie-2.dtsi

-- 
1.8.5.3
