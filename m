From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed,  3 Aug 2011 00:08:25 +0100
Subject: [PATCH 0/4] Add device tree enabled Exynos4 machine
Message-ID: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a basic device tree enabled machine for Samsung's Exynos4
processor. This enables further development of device tree coverge for
Exynos4. A basic device tree source file for Exynos4 processor and the
smdkv310 board is also included.

The device tree enabled machine has been boot tested till serial console.
The watchdog driver is probed with information from dtb.

Notes:
- The interrupt controller device tree bindings are not documented yet. That
  is because, it will be replaced with a new irq_domain support soon.


Thomas Abraham (4):
  serial: samsung: Keep a copy of the location of platform data in driver's private data
  serial: s5pv210: Add device tree support
  arm: exynos4: Add a new Exynos4 device tree enabled machine
  arm: dts: Add device tree source file for Exynos4 platforms

 Documentation/devicetree/bindings/arm/samsung.txt  |    8 ++
 .../devicetree/bindings/serial/samsung_uart.txt    |   16 ++++
 arch/arm/boot/dts/exynos4-smdkv310.dts             |   31 +++++++
 arch/arm/boot/dts/exynos4.dtsi                     |   72 +++++++++++++++++
 arch/arm/mach-exynos4/Kconfig                      |   10 +++
 arch/arm/mach-exynos4/Makefile                     |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c            |   84 ++++++++++++++++++++
 drivers/tty/serial/s5pv210.c                       |   55 ++++++++++++-
 drivers/tty/serial/samsung.c                       |   19 ++++-
 drivers/tty/serial/samsung.h                       |    4 +-
 10 files changed, 292 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung.txt
 create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
 create mode 100644 arch/arm/boot/dts/exynos4-smdkv310.dts
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c
