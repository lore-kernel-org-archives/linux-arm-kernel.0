From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 Nov 2011 16:32:23 +0530
Subject: [PATCH 0/3] OMAP serial device tree support
Message-ID: <1321441346-19591-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds minimal device tree support for
OMAP-serial driver, and is based on top of the latest
runtime-PM changes from Govind[1] posted here[2].

The series passes minimal data that allows serial console
boot, with UART's initialised from device tree.
However some of low power support for UART and remote
wakeup needs more work.
Boot tested on OMAP4 panda and OMAP4 sdp boards.

[1] git://gitorious.org/runtime_3-0/runtime_3-0.git 3.2-rc1_uart_runtime
[2] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg58486.html

Rajendra Nayak (3):
  ARM: omap_device: handle first time activation of console device
  omap-serial: Add minimal device tree support
  ARM: omap: pass minimal SoC/board data for UART from dt

 .../devicetree/bindings/arm/omap/omap.txt          |    1 +
 .../devicetree/bindings/serial/omap_serial.txt     |    8 ++++
 arch/arm/boot/dts/omap3-beagle.dts                 |   17 +++++++++
 arch/arm/boot/dts/omap3.dtsi                       |   27 ++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   17 +++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   17 +++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   24 +++++++++++++
 arch/arm/mach-omap2/board-generic.c                |    1 -
 arch/arm/plat-omap/omap_device.c                   |   33 +++++++++++++++++-
 drivers/tty/serial/omap-serial.c                   |   37 +++++++++++++++++++-
 10 files changed, 179 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt
