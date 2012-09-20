From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 20 Sep 2012 17:45:06 +1200
Subject: [GIT PULL RESEND] arm-soc: vt8500: Convert mach-vt8500 to devicetree
Message-ID: <1348119906.8199.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please disregard the last pull request - commit id's were invalid.
This one is now correct.

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.code.sf.net/p/linuxwmt/code tags/vt8500-for-next

for you to fetch changes up to 0cd5434aae73698aa4a48542bd8d1428d44820cb:

  arm: vt8500: Update arch-vt8500 to devicetree support. (2012-09-20 07:23:26 +1200)

----------------------------------------------------------------
Update mach-vt8500 to devicetree and remove non-dt code.

----------------------------------------------------------------
Tony Prisk (8):
      arm: vt8500: Add device tree files for VIA/Wondermedia SoC's
      rtc: vt8500: Add devicetree support for vt8500-rtc
      serial: vt8500: Add devicetree support for vt8500-serial
      video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb
      arm: vt8500: clk: Add Common Clock Framework support
      arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
      arm: vt8500: gpio: Devicetree support for arch-vt8500
      arm: vt8500: Update arch-vt8500 to devicetree support.

 Documentation/devicetree/bindings/arm/vt8500.txt   |   14 +
 .../bindings/arm/vt8500/via,vt8500-intc.txt        |   16 +
 .../bindings/arm/vt8500/via,vt8500-pmc.txt         |   13 +
 .../bindings/arm/vt8500/via,vt8500-timer.txt       |   15 +
 Documentation/devicetree/bindings/clock/vt8500.txt |   72 +++
 .../devicetree/bindings/gpio/gpio-vt8500.txt       |   24 +
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     |   15 +
 .../bindings/tty/serial/via,vt8500-uart.txt        |   17 +
 .../devicetree/bindings/usb/platform-uhci.txt      |   15 +
 .../devicetree/bindings/usb/via,vt8500-ehci.txt    |   15 +
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 .../devicetree/bindings/video/via,vt8500-fb.txt    |   48 ++
 .../devicetree/bindings/video/wm,prizm-ge-rops.txt |   13 +
 .../devicetree/bindings/video/wm,wm8505-fb.txt     |   21 +
 arch/arm/Kconfig                                   |    5 +
 arch/arm/boot/dts/vt8500-bv07.dts                  |   31 ++
 arch/arm/boot/dts/vt8500.dtsi                      |  115 +++++
 arch/arm/boot/dts/wm8505-ref.dts                   |   31 ++
 arch/arm/boot/dts/wm8505.dtsi                      |  142 ++++++
 arch/arm/boot/dts/wm8650-mid.dts                   |   31 ++
 arch/arm/boot/dts/wm8650.dtsi                      |  146 ++++++
 arch/arm/mach-vt8500/Kconfig                       |   72 +--
 arch/arm/mach-vt8500/Makefile                      |    9 +-
 arch/arm/mach-vt8500/bv07.c                        |   80 ---
 arch/arm/mach-vt8500/common.h                      |   28 ++
 arch/arm/mach-vt8500/devices-vt8500.c              |   91 ----
 arch/arm/mach-vt8500/devices-wm8505.c              |   99 ----
 arch/arm/mach-vt8500/devices.c                     |  270 -----------
 arch/arm/mach-vt8500/devices.h                     |   88 ----
 arch/arm/mach-vt8500/gpio.c                        |  240 ---------
 arch/arm/mach-vt8500/include/mach/restart.h        |    4 +-
 arch/arm/mach-vt8500/include/mach/vt8500_irqs.h    |   88 ----
 arch/arm/mach-vt8500/include/mach/vt8500_regs.h    |   79 ---
 arch/arm/mach-vt8500/include/mach/wm8505_irqs.h    |  115 -----
 arch/arm/mach-vt8500/include/mach/wm8505_regs.h    |   78 ---
 arch/arm/mach-vt8500/irq.c                         |  209 ++++----
 arch/arm/mach-vt8500/restart.c                     |   54 ---
 arch/arm/mach-vt8500/timer.c                       |   67 ++-
 arch/arm/mach-vt8500/vt8500.c                      |  196 ++++++++
 arch/arm/mach-vt8500/wm8505_7in.c                  |   79 ---
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-vt8500.c                           |  510 ++++++++++++++++++++
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-vt8500.c                         |  316 ++++++++++++
 drivers/rtc/rtc-vt8500.c                           |    9 +-
 drivers/tty/serial/vt8500_serial.c                 |   58 ++-
 drivers/video/Kconfig                              |    6 +-
 drivers/video/vt8500lcdfb.c                        |   79 ++-
 drivers/video/wm8505fb.c                           |   97 +++-
 drivers/video/wmt_ge_rops.c                        |    9 +-
 51 files changed, 2265 insertions(+), 1574 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt
 create mode 100644 Documentation/devicetree/bindings/clock/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt
 create mode 100644 Documentation/devicetree/bindings/usb/platform-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/video/via,vt8500-fb.txt
 create mode 100644 Documentation/devicetree/bindings/video/wm,prizm-ge-rops.txt
 create mode 100644 Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
 create mode 100644 arch/arm/boot/dts/vt8500-bv07.dts
 create mode 100644 arch/arm/boot/dts/vt8500.dtsi
 create mode 100644 arch/arm/boot/dts/wm8505-ref.dts
 create mode 100644 arch/arm/boot/dts/wm8505.dtsi
 create mode 100644 arch/arm/boot/dts/wm8650-mid.dts
 create mode 100644 arch/arm/boot/dts/wm8650.dtsi
 delete mode 100644 arch/arm/mach-vt8500/bv07.c
 create mode 100644 arch/arm/mach-vt8500/common.h
 delete mode 100644 arch/arm/mach-vt8500/devices-vt8500.c
 delete mode 100644 arch/arm/mach-vt8500/devices-wm8505.c
 delete mode 100644 arch/arm/mach-vt8500/devices.c
 delete mode 100644 arch/arm/mach-vt8500/devices.h
 delete mode 100644 arch/arm/mach-vt8500/gpio.c
 delete mode 100644 arch/arm/mach-vt8500/include/mach/vt8500_irqs.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/vt8500_regs.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/wm8505_irqs.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/wm8505_regs.h
 delete mode 100644 arch/arm/mach-vt8500/restart.c
 create mode 100644 arch/arm/mach-vt8500/vt8500.c
 delete mode 100644 arch/arm/mach-vt8500/wm8505_7in.c
 create mode 100644 drivers/clk/clk-vt8500.c
 create mode 100644 drivers/gpio/gpio-vt8500.c
