From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon,  1 Aug 2011 17:20:35 +0100
Subject: Add device tree enabled Exynos4 machine
Message-ID: <1312215637-716-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a basic device tree enabled machine for Samsung's Exynos4
processor. This enables further development of device tree coverge for
Exynos4. A basic device tree source file for Exynos4 processor and the
smdkv310 board is also included.

The device tree enabled machine has been boot tested till serial console.
The watchdog driver is probed with information from dtb.

Notes:
A. The interrupt controller device tree bindings are not documented yet. That
   is because, it will be replaced with a new irq_domain support soon.

Thomas Abraham (2):
  arm: exynos4: Add a new Exynos4 device tree enabled machine
  arm: dt: Add device tree source file for Exynos4 and let boards include it

 Documentation/devicetree/bindings/arm/samsung.txt |    8 ++
 arch/arm/boot/dts/exynos4-smdkv310.dts            |   31 ++++++
 arch/arm/boot/dts/exynos4.dtsi                    |   44 ++++++++
 arch/arm/mach-exynos4/Kconfig                     |   10 ++
 arch/arm/mach-exynos4/Makefile                    |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c           |  118 +++++++++++++++++++++
 6 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung.txt
 create mode 100644 arch/arm/boot/dts/exynos4-smdkv310.dts
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c
