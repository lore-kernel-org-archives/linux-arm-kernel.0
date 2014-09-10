From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 10 Sep 2014 11:04:01 -0500
Subject: [PATCH v3 0/3] OMAP4+: Get rid of internal SRAM handling
Message-ID: <cover.1410362895.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
Fix minor issue in last patch to check for null sram_pool if no sram
phandle is given in DT.

Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
use drivers/misc/sram.c driver instead of the omap internal
implementation for SRAM handling.

Previous discussion can be found at [1].

Regards,
Dave

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195588.html

Rajendra Nayak (3):
  ARM: AM335x: Get rid of unused sram init function
  ARM: OMAP4+: Move SRAM data to DT
  ARM: OMAP4+: Remove static iotable mappings for SRAM

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  3 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  5 ++-
 arch/arm/boot/dts/am4372.dtsi                      |  5 +++
 arch/arm/boot/dts/omap4.dtsi                       |  6 ++++
 arch/arm/boot/dts/omap5.dtsi                       |  8 ++++-
 arch/arm/configs/omap2plus_defconfig               |  1 +
 arch/arm/mach-omap2/io.c                           | 17 ----------
 arch/arm/mach-omap2/omap4-common.c                 | 22 +++++++++++-
 arch/arm/mach-omap2/sram.c                         | 39 +---------------------
 arch/arm/mach-omap2/sram.h                         |  7 ----
 10 files changed, 46 insertions(+), 67 deletions(-)

-- 
1.9.0
