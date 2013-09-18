From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 Sep 2013 05:11:01 +0900
Subject: [PATCH 00/03] ARM: shmobile: Initial r7s72100 SoC and Genmai board
 support
Message-ID: <20130918201101.6319.97667.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Initial r7s72100 SoC and Genmai board support

[PATCH 01/03] ARM: shmobile: Initial r7s72100 SoC support
[PATCH 02/03] ARM: shmobile: r7s72100 SCIF support
[PATCH 03/03] ARM: shmobile: Genmai support

This series adds initial support for r7s72100 and Genmai. The SoC
is known as r7s72100 which is based on a single core Cortex-A9
and makes use of SCIF for serial. Many other on-chip I/O devices
are available, and support for those will be added by incremental
feature patches.

This initial SoC and board support is providing limited DT-only
support and a very basic C-version of board support. In the future
improved PINCTRL and common clock framework support will be added.

Implemented in same style as r8a7790 and r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20130906

 arch/arm/boot/dts/Makefile                     |    1 
 arch/arm/boot/dts/r7s72100-genmai.dts          |   31 +++
 arch/arm/boot/dts/r7s72100.dtsi                |   36 ++++
 arch/arm/mach-shmobile/Kconfig                 |   11 +
 arch/arm/mach-shmobile/Makefile                |    3 
 arch/arm/mach-shmobile/Makefile.boot           |    1 
 arch/arm/mach-shmobile/board-genmai.c          |   43 +++++
 arch/arm/mach-shmobile/clock-r7s72100.c        |  202 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r7s72100.h |    8 
 arch/arm/mach-shmobile/setup-r7s72100.c        |   88 ++++++++++
 10 files changed, 424 insertions(+)
