From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Aug 2013 15:41:43 +0530
Subject: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
Message-ID: <1377598305-15539-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
use drivers/misc/sram.c driver instead of the omap internal
implementation for SRAM handling.

Rajendra Nayak (2):
  ARM: AM335x: Get rid of unused sram init function
  ARM: OMAP4+: Move SRAM data to DT

 arch/arm/boot/dts/am33xx.dtsi        |    5 +++++
 arch/arm/boot/dts/am4372.dtsi        |    5 +++++
 arch/arm/boot/dts/omap4.dtsi         |    5 +++++
 arch/arm/boot/dts/omap5.dtsi         |    5 +++++
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/sram.c           |   39 +---------------------------------
 arch/arm/mach-omap2/sram.h           |    1 -
 7 files changed, 22 insertions(+), 39 deletions(-)

-- 
1.7.9.5
