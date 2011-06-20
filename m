From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 20 Jun 2011 16:32:26 +0530
Subject: [PATCH 0/6] Add basic device tree support for Samsung's Exynos4
	platform
Message-ID: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a basic device tree based boot for Samsung's Exynos4
platforms and specifically for smdkv310 board. Device tree based driver
probe is added for uart, sdhci and watchdog drivers. These patches
enable booting to console on smdkv310 board with some of the devices
initialized with data from the device tree.

This patch series is based on
git.secretlab.ca/git/linux-2.6.git devicetree/test

and depends on the following patches which are not yet available in
the devicetree/test branch.

1. [PATCH] ARM: EXYNOS4: Fix card detection for sdhci 0 and 2
[http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg04704.html]

2. [PATCH] ARM: EXYNOS4: Fix missing S5P_VA_AUDSS definition
[http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg04866.html]

3. [PATCH 0/9] Add clkdev support for Samsung platforms
[http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg04874.html]

4. Consolidate the clkdev header files
[http://patchwork.ozlabs.org/patch/97862/]

Thomas Abraham (6):
  serial: samsung: Keep a copy of platform data in driver's private data
  serial: samsung: Add device tree support for s5pv210 uart driver
  watchdog: s3c2410: Add support for device tree based probe
  mmc: sdhci-s3c: Add support for device tree based probe
  arm: dts: Add nodes in smdkv310 device tree source file
  arm: exynos4: Add a new Exynos4 device tree enabled machine

 Documentation/devicetree/bindings/arm/samsung.txt  |    3 +-
 .../bindings/tty/serial/samsung_uart.txt           |   50 +++++++
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   12 ++
 arch/arm/boot/dts/exynos4-smdkv310.dts             |  135 +++++++++++++++++++-
 arch/arm/mach-exynos4/Kconfig                      |   11 ++
 arch/arm/mach-exynos4/Makefile                     |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c            |   94 ++++++++++++++
 drivers/mmc/host/sdhci-s3c.c                       |   11 ++
 drivers/tty/serial/s5pv210.c                       |   39 +++++-
 drivers/tty/serial/samsung.c                       |  114 ++++++++++++++++-
 drivers/tty/serial/samsung.h                       |    4 +-
 drivers/watchdog/s3c2410_wdt.c                     |   10 ++
 12 files changed, 473 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/samsung_uart.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c
