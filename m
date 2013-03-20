From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 20 Mar 2013 23:36:04 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a7790 SoC and Lager board support
Message-ID: <20130320143604.32377.32634.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7790 SoC and Lager board support

[PATCH 01/04] ARM: shmobile: Initial r8a7790 SoC support
[PATCH 02/04] ARM: shmobile: r8a7790 SCIF support
[PATCH 03/04] ARM: shmobile: r8a7790 IRQC support
[PATCH 04/04] ARM: shmobile: Lager support

This series adds initial support for r8a7790 and Lager. The SoC
is known as r8a7790 which is built around Cortex-A15 and makes use
of SCIF for serial and IRQC interrupt controller for external IRQs.

This initial SoC and board support is providing limited DT-only
support and a very basic C-version of board support. In the future
improved PINCTRL and clock framework support will be added, followed
by SMP support.

Implemented in same style as r8a73a4 SoC V2 and APE6EVM Board V2.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against all+next in renesas.git plus r8a73a4 patches
 [PATCH 03/04] requires the IRQC driver to build

 arch/arm/boot/dts/Makefile                    |    1 
 arch/arm/boot/dts/r8a7790-lager.dts           |   26 +++++
 arch/arm/boot/dts/r8a7790.dtsi                |   63 ++++++++++++
 arch/arm/mach-shmobile/Kconfig                |   17 +++
 arch/arm/mach-shmobile/Makefile               |    2 
 arch/arm/mach-shmobile/board-lager.c          |   46 +++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c        |   95 ++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    7 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |  127 +++++++++++++++++++++++++
 9 files changed, 382 insertions(+), 2 deletions(-)
