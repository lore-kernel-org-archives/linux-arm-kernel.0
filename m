From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 26 Mar 2013 10:34:14 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V3
Message-ID: <20130326013414.11796.9937.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a73a4 SoC support V3
[PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V3
[PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
[PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
[PATCH 04/04] ARM: shmobile: r8a73a4 PFC support

This series is V3 of initial support for the r8a73a4 SoC. The SoC
is known as r8a73a4 which is built around Cortex-A15 and makes use
of SCIF for serial, IRQC interrupt controller for external IRQs and
PFC for combined support for pinmux and GPIO.

Changes in V3:
- Added clock mapping for all supported root clocks
- Fixed a bug in the SCIF patch where PORT_SCIFA was always being selected

Updated PFC and APE6EVM series will be on top of this one.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "next" renesas.git 442d651d3764ba4203c6b766a1ddd3ac24a40410
 [PATCH 01/04] requires [PATCH] ARM: shmobile: Disallow PINCTRL without GPIOLIB
 [PATCH 03/04] requires the IRQC driver to build

 arch/arm/boot/dts/r8a73a4.dtsi                |   87 +++++++++++
 arch/arm/mach-shmobile/Kconfig                |    9 +
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/clock-r8a73a4.c        |  106 ++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    8 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |  187 +++++++++++++++++++++++++
 6 files changed, 397 insertions(+), 1 deletion(-)
