From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 13:36:30 +0800
Subject: [GIT PULL] mxs device tree changes for 3.6
Message-ID: <20120706053628.GC20503@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs device tree related changes for 3.6.

Regards,
Shawn

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt-for-3.6

Fabio Estevam (3):
      serial: mxs-auart: Allow device tree probing
      ARM: dts: mx28evk: Add auart0 and auart3 support
      ARM: mx23: Add initial support for olinuxino board

Huang Shijie (2):
      ARM: mx28: add gpmi-nand support
      ARM: dts: mx23: add gpmi nand support

Marc Kleine-Budde (1):
      ARM: mxs: enable flexcan on imx28

Marek Vasut (2):
      ARM: dts: imx23: Fix the gpmi/gpmi-nand DT name
      rtc: stmp3xxx: Add simple binding for the stmp3xxx-rtc

Maxime Ripard (3):
      ARM: dts: imx28: Add additionnal muxing options to iMX28 DTSI
      ARM: mxs: Add Crystalfontz CFA-10036 DTS
      ARM: dts: cfa10036: Add Power LED to the CFA-10036 board

Shawn Guo (15):
      ARM: mxs: store mac address read from OTP in device tree
      video: mxsfb: move mxsfb.h into include/linux
      video: mxsfb: add simple device tree probe
      ARM: mxs: use auxdata to attach mxsfb_platform_data
      ARM: dts: mxs: add comments for pinmux-ids
      ARM: dts: mxs: add hog-gpios for imx23-evk and imx28-evk
      ARM: dts: imx23-evk: updates for mmc device
      ARM: dts: imx23-evk: add auart device
      ARM: dts: imx28-evk: add vmmc-supply for mmc device
      ARM: dts: imx28-evk: add missing properties for fec
      ARM: dts: imx28-evk: add heartbeat gpio-leds
      ARM: dts: mxs: enable rtc for imx23 and imx28
      ARM: dts: mxs: add pwm-backlight for imx23-evk and imx28-evk
      ARM: dts: mxs: add lcd support for imx23-evk and imx28-evk
      ARM: dts: imx28-evk: add flexan devices

 Documentation/devicetree/bindings/arm/olimex.txt   |    6 +
 Documentation/devicetree/bindings/fb/mxsfb.txt     |   19 ++
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       |   16 ++
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   27 ++
 arch/arm/boot/dts/cfa10036.dts                     |   52 ++++
 arch/arm/boot/dts/imx23-evk.dts                    |   66 +++++-
 arch/arm/boot/dts/imx23-olinuxino.dts              |   44 ++++
 arch/arm/boot/dts/imx23.dtsi                       |  169 ++++++++++++-
 arch/arm/boot/dts/imx28-evk.dts                    |  100 ++++++++
 arch/arm/boot/dts/imx28.dtsi                       |  267 ++++++++++++++++++--
 arch/arm/mach-mxs/Kconfig                          |    1 +
 arch/arm/mach-mxs/devices-mx23.h                   |    2 +-
 arch/arm/mach-mxs/devices-mx28.h                   |    2 +-
 arch/arm/mach-mxs/devices/platform-mxsfb.c         |    2 +-
 arch/arm/mach-mxs/mach-mxs.c                       |  128 ++++++++++-
 drivers/rtc/rtc-stmp3xxx.c                         |    8 +
 drivers/tty/serial/mxs-auart.c                     |   42 +++-
 drivers/video/mxsfb.c                              |   62 ++++-
 .../include/mach => include/linux}/mxsfb.h         |    6 +-
 19 files changed, 953 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/olimex.txt
 create mode 100644 Documentation/devicetree/bindings/fb/mxsfb.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
 create mode 100644 arch/arm/boot/dts/cfa10036.dts
 create mode 100644 arch/arm/boot/dts/imx23-olinuxino.dts
 rename {arch/arm/mach-mxs/include/mach => include/linux}/mxsfb.h (95%)
