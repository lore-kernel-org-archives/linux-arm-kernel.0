From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Mar 2013 23:32:03 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
Message-ID: <20130318143203.26687.98180.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a73a4 SoC support V2

[PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V2
[PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V2
[PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
[PATCH 04/04] ARM: shmobile: r8a73a4 PFC support

This series is V2 of initial support for the r8a73a4 SoC. The SoC
is known as r8a73a4 which is built around Cortex-A15 and makes use
of SCIF for serial, IRQC interrupt controller for external IRQs and
PFC for combined support for pinmux and GPIO.

Changes in V2:
- Move away from static platform devices
- Use platform_device_register_data/resndata/simple
- Add PFC support (tables excluded)
- About 150 lines smaller than V1 but without board code

For more details please see the individual patches.

The previous patch set included APE6EVM board support, but from now
board support will be submitted separately as an independent series.

Also, this series makes use of PFC if available, but actual PFC tables
will be submitted separately.

Many thanks to Arnd Bergmann for his kind support!

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
 [PATCH 01/04] requires [PATCH] ARM: shmobile: Disallow PINCTRL without GPIOLIB
 [PATCH 03/04] requires the IRQC driver to build

 arch/arm/boot/dts/r8a73a4.dtsi                |   87 +++++++++++
 arch/arm/mach-shmobile/Kconfig                |    9 +
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/clock-r8a73a4.c        |  104 +++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    8 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |  187 +++++++++++++++++++++++++
 6 files changed, 395 insertions(+), 1 deletion(-)
