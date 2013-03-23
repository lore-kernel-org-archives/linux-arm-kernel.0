From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 23 Mar 2013 13:57:27 +0100
Subject: [PATCH 0/3] ARM: zynq: add SMP support for zynq7000
Message-ID: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series adds SMP support for the Zynq SoCs.
It goes along the lines of socfpga: the jump goes via RAM.
Other CortexA9 based SoCs seem to go via some sort of general purpose register.
These two SoCs do not have that.

This series was tested on a ZedBoard which has 2 cores.

Regards,
Steffen

Steffen Trumtrar (3):
  ARM: zynq: read scu base from SoC
  ARM: zynq: get slcr base earlier
  ARM: zynq: add SMP support

 arch/arm/boot/dts/zynq-7000.dtsi |  19 +++++++
 arch/arm/mach-zynq/Makefile      |   2 +
 arch/arm/mach-zynq/common.c      |  56 +++++++++++++-------
 arch/arm/mach-zynq/common.h      |  14 +++++
 arch/arm/mach-zynq/headsmp.S     |  20 +++++++
 arch/arm/mach-zynq/platsmp.c     | 110 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 203 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-zynq/headsmp.S
 create mode 100644 arch/arm/mach-zynq/platsmp.c

-- 
1.8.2.rc2
