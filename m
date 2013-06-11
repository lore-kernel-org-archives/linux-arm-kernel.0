From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Jun 2013 16:48:55 +0200
Subject: [PATCH 0/3] ARM: dts: OMAP3: Use constants with MTD devices
Message-ID: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Legacy board files use constants from sizes.h and mtd/partitions.h
to declare MTD partitions. This series performs the same with DT.

Necessary headers are added (patch 1), a NAND node is added to
omap3-overo (patch 2), and remaining DTS are converted (patch 3).

Patch 2 was tested on the real hardware. For patch 3, the resulting
DTB were diff'ed. The MTDPART_SIZ_FULL constant was used in DTS, when
it was the case in legacy board files. The size cell is thus changed
inside the binary output, so testing on the hardware is welcome, even
if it should work transparently.

Note that inside omap3430-sdp.dts (nor at 0,0), it appears with
this series that partitions 'kernel-nor' and 'filesystem-nor' overlaps
by (2*SZ_128K), which is probably not desired.

Regards,

Florian

Florian Vaussard (3):
  ARM: dts: Add headers with constants for MTD partitions
  ARM: dts: Add omap3-overo NAND flash memory binding
  ARM: dts: OMAP3: Use MTD constants for OMAP3 boards

 arch/arm/boot/dts/omap3-devkit8000.dts |   10 +++---
 arch/arm/boot/dts/omap3-igep0020.dts   |   10 +++---
 arch/arm/boot/dts/omap3-igep0030.dts   |   10 +++---
 arch/arm/boot/dts/omap3-overo.dtsi     |   50 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi           |    2 +
 arch/arm/boot/dts/omap3430-sdp.dts     |   28 ++++++++--------
 include/dt-bindings/mtd/partitions.h   |   12 +++++++
 include/dt-bindings/sizes.h            |   52 ++++++++++++++++++++++++++++++++
 8 files changed, 145 insertions(+), 29 deletions(-)
 create mode 100644 include/dt-bindings/mtd/partitions.h
 create mode 100644 include/dt-bindings/sizes.h

-- 
1.7.5.4
