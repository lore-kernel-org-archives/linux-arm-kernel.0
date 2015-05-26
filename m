From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 27 May 2015 00:25:56 +0800
Subject: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add pwrkey
 driver
Message-ID: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Tested old and new dts in imx6sx platform.

Change from v5 to v6
 - use dev_warn and dev_err
 - use phandle regmap
 - update document and dts for phandle regmap
 - use data variable in rtc-snvs.c

Change from v3 to v4
 - fix align
 - change to pr_warn

Change from v2 to v3
 - Keep snvs rtc compatiblity with old dts file
 - use general syscon-poweroff instead of modifying snvs-poweroff.c

Change from v1 to v2
 - Change simple-bus to simple-mfd
 - RTC remove lock.
 - RTC remove comments "These register offsets are relative to LP (Low Power) range"
 - power off, remove extra space

Frank Li (5):
  rtc: arm: imx: snvs: change use syscon to access register
  Document: dt: fsl: snvs: change support syscon
  ARM: dts: imx: update snvs to use syscon access register
  Document: devicetree: input: imx: i.mx snvs power device tree bindings
  ARM: dts: imx6sx: enable snvs power key

Robin Gong (1):
  input: keyboard: imx: add snvs power key driver

 .../devicetree/bindings/crypto/fsl-sec4.txt        |  91 +++++++--
 .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |  21 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  21 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  28 ++-
 arch/arm/boot/dts/vfxxx.dtsi                       |  11 +-
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/snvs_pwrkey.c               | 227 +++++++++++++++++++++
 drivers/rtc/rtc-snvs.c                             | 132 ++++++------
 10 files changed, 431 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c

-- 
1.9.1
