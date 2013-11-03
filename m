From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 Nov 2013 10:30:11 +0100
Subject: [PATCH 0/2] Add SMP support for the Allwinner A31 SoCs
Message-ID: <1383471013-21695-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

The Allwinner A31 is a quad-Cortex-A7 SoC. This patchset adds support
for the bringup of the others CPUs at startup.

Thanks,
Maxime

Maxime Ripard (2):
  ARM: sun6i: dt: Add IP needed to bring up the additional cores
  ARM: sun6i: Add SMP support for the Allwinner A31

 arch/arm/boot/dts/sun6i-a31.dtsi |  10 ++++
 arch/arm/mach-sunxi/Makefile     |   1 +
 arch/arm/mach-sunxi/common.h     |  19 +++++++
 arch/arm/mach-sunxi/headsmp.S    |  11 ++++
 arch/arm/mach-sunxi/platsmp.c    | 115 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c      |   3 +
 6 files changed, 159 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/common.h
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 arch/arm/mach-sunxi/platsmp.c

-- 
1.8.4
