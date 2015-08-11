From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Aug 2015 00:42:29 +0800
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.3
Message-ID: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This is the i.MX SoC changes for 4.3.  There are some input and rtc
changes, because they are applied as a series.  Subsystem maintainers
have ACKed these changes, so it should be fine to send them via arm-soc
tree.

Shawn

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.3

for you to fetch changes up to 8a0fa1843638c5078e6606114ed8bdf9ea56fab1:

  rtc: snvs: select option REGMAP_MMIO (2015-08-11 23:04:47 +0800)

----------------------------------------------------------------
The i.MX SoC changes for 4.3:
 - Add i.MX6 Ultralite SoC support, which is the newest addition to
   i.MX6 family.  It integrates a single Cortex-A7 core and a power
   management module that reduces the complexity of external power
   supply and simplifies power sequencing.
 - Change SNVS RTC driver to use syscon interface for register access,
   and add SNVS power key driver support.
 - Add a second clock for mxc rtc driver, and support device tree probe
   for the driver.
 - Add FEC MAC reference clock and phy fixup initialization for i.MX6UL
   platform.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: add low-level debug support for i.mx6ul

Frank Li (4):
      ARM: imx: add i.mx6ul msl support
      rtc: snvs: use syscon to access register
      Document: dt: fsl: snvs: change support syscon
      Document: devicetree: input: imx: i.mx snvs power device tree bindings

Fugang Duan (2):
      ARM: imx6ul: add fec bits to GPR syscon definition
      ARM: imx6ul: add fec MAC refrence clock and phy fixup init

Philippe Reynes (3):
      rtc: mxc: use a second rtc clock
      dt-binding: document the binding for mxc rtc
      rtc: mxc: add support of device tree

Robin Gong (1):
      input: keyboard: imx: add snvs power key driver

Shawn Guo (2):
      input: snvs_pwrkey: use "wakeup-source" as deivce tree property name
      rtc: snvs: select option REGMAP_MMIO

 .../devicetree/bindings/crypto/fsl-sec4.txt        |  91 +++++++--
 .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
 Documentation/devicetree/bindings/rtc/rtc-mxc.txt  |  26 +++
 arch/arm/Kconfig.debug                             |   9 +
 arch/arm/include/debug/imx-uart.h                  |  13 ++
 arch/arm/mach-imx/Kconfig                          |   8 +
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/mach-imx6ul.c                    |  86 ++++++++
 arch/arm/mach-imx/mxc.h                            |   6 +
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/snvs_pwrkey.c               | 227 +++++++++++++++++++++
 drivers/rtc/Kconfig                                |   1 +
 drivers/rtc/rtc-mxc.c                              |  60 ++++--
 drivers/rtc/rtc-snvs.c                             | 132 ++++++------
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   8 +
 17 files changed, 592 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
 create mode 100644 arch/arm/mach-imx/mach-imx6ul.c
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c
