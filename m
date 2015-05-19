From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 20 May 2015 01:04:35 +0800
Subject: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add pwrkey
 driver
Message-ID: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Change from v1 to v2
 - Change simple-bus to simple-mfd
 - RTC remove lock.
 - RTC remove comments "These register offsets are relative to LP (Low Power) range"
 - power off, remove extra space

SNVS is MPF module.
include rtc, power off, ON/OFF power key

  arm: imx: power-off: change to syscon to access register
  rtc: arm: imx: snvs: change use syscon to access register
Above two patch change existed power-off and rtc use syscon

  Document: dt: fsl: snvs: change support syscon
  arm: dts: imx: update snvs to use syscon access register
Update dt file and document

  input: keyboard: imx: add snvs power key driver
  document: devicetree: input: imx: i.mx snvs power device tree bindings
  arm: dts: imx6sx: enable snvs power key
Added on/off key driver

Frank Li (6):
  arm: imx: power-off: change to syscon to access register
  rtc: arm: imx: snvs: change use syscon to access register
  Document: dt: fsl: snvs: change support syscon
  arm: dts: imx: update snvs to use syscon access register
  document: devicetree: input: imx: i.mx snvs power device tree bindings
  arm: dts: imx6sx: enable snvs power key

Robin Gong (1):
  input: keyboard: imx: add snvs power key driver

 .../devicetree/bindings/crypto/fsl-sec4.txt        |  93 +++++++--
 .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
 .../bindings/power_supply/imx-snvs-poweroff.txt    |  24 +--
 arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  12 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  19 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |   9 +-
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/snvs_pwrkey.c               | 232 +++++++++++++++++++++
 drivers/power/reset/imx-snvs-poweroff.c            |  21 +-
 drivers/rtc/rtc-snvs.c                             | 128 +++++-------
 12 files changed, 417 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c

-- 
1.9.1
