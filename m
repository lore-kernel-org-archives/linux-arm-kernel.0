From: carlo@caione.org (Carlo Caione)
Date: Tue, 17 Nov 2015 15:56:35 +0100
Subject: [PATCH 0/7] Add basic SMP support for Amlogic Meson8b
Message-ID: <1447772202-12418-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patchset adds SMP support for Amlogic Meson8b SoCs.

Patch 1 fix some paramater for L2 cache needed for SMP.
Patches 2-4 add a small reset controller used to reset the CPU cores at boot.
Patches 5-7 deal with the SMP code itself.

Carlo Caione (7):
  ARM: DTS: meson8b: Extend L2 cache controller node
  Documentation: bindings: Define CPU reset controller
  clk: meson8b: Add reset controller for CPU cores
  ARM: DTS: meson8b: Enable reset controller
  Documentation: bindings: Add SMP related documentation
  ARM: meson8b: Add SMP bringup code
  ARM: DTS: meson8b: Add SMP related nodes

 .../devicetree/bindings/arm/amlogic/pmu.txt        |  16 ++
 .../devicetree/bindings/arm/amlogic/smp-sram.txt   |  32 +++
 .../arm/cpu-enable-method/amlogic,meson8b-smp      |  53 +++++
 .../bindings/clock/amlogic,meson8b-clkc.txt        |   6 +-
 arch/arm/boot/dts/meson8b.dtsi                     |  32 +++
 arch/arm/mach-meson/Kconfig                        |   1 +
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/platsmp.c                      | 228 +++++++++++++++++++++
 drivers/clk/meson/clk-cpu.c                        |  60 +++++-
 drivers/clk/meson/clkc.c                           |   5 +-
 drivers/clk/meson/clkc.h                           |   6 +-
 drivers/clk/meson/meson8b-clkc.c                   |   4 +-
 include/dt-bindings/clock/meson8b-clkc.h           |   5 +
 13 files changed, 441 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/amlogic,meson8b-smp
 create mode 100644 arch/arm/mach-meson/platsmp.c

-- 
2.5.0
