From: carlo@caione.org (Carlo Caione)
Date: Wed,  2 Dec 2015 18:22:26 +0100
Subject: [PATCH v2 0/7] Add basic SMP support for Amlogic Meson8b
Message-ID: <1449076953-5058-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patchset adds SMP support for Amlogic Meson8b SoCs.

Patch 1 fix some paramater for L2 cache needed for SMP.
Patches 2-4 add a small reset controller used to reset the CPU cores at boot.
Patches 5-7 deal with the SMP code itself.

Changelog:

V2:
    - Add forgotten textofs-$(CONFIG_ARCH_MESON)
    - Checking for of_reset_control_get() failure
    - Use more specific subjects

Carlo Caione (7):
  ARM: DTS: Amlogic: Extend L2 cache controller node for Meson8b
  dt-bindings: Amlogic: Document the CPU reset controller for Meson8b
  clk: Amlogic: Add reset controller for CPU cores for Meson8b
  ARM: DTS: Amlogic: Enable reset controller for Meson8b
  dt-bindings: Amlogic: Add SMP related documentation
  ARM: Amlogic: Add SMP bringup code for Meson8b
  ARM: DTS: Amlogic: Add SMP related nodes for Meson8b

 .../devicetree/bindings/arm/amlogic/pmu.txt        |  16 ++
 .../devicetree/bindings/arm/amlogic/smp-sram.txt   |  32 +++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../bindings/clock/amlogic,meson8b-clkc.txt        |   6 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/meson8b.dtsi                     |  32 +++
 arch/arm/mach-meson/Kconfig                        |   1 +
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/platsmp.c                      | 234 +++++++++++++++++++++
 drivers/clk/meson/clk-cpu.c                        |  60 +++++-
 drivers/clk/meson/clkc.c                           |   5 +-
 drivers/clk/meson/clkc.h                           |   6 +-
 drivers/clk/meson/meson8b-clkc.c                   |   4 +-
 include/dt-bindings/clock/meson8b-clkc.h           |   5 +
 14 files changed, 396 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
 create mode 100644 arch/arm/mach-meson/platsmp.c

-- 
2.5.0
