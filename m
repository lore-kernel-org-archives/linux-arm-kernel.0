From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Dec 2014 15:39:43 +1300
Subject: [RFC/PATCH 0/4] Add support for Marvell's RD-DXBC2 
Message-ID: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allows me to boot v3.18 on Marvell's reference board and
start up a basic userspace. I've sent 1/4 and 2/4 to the list
individually before but hopefully they will be more meaningful when
viewed in context.

Thanks,
Chris

Chris Packham (4):
  ARM: mvebu: use dt_fixup to provide fallback for enable-method
  clk: mvebu: armada-xp: Support for 98DX4251
  ARM: mvebu: Initial support for rd-dxbc2
  ARM: mvebu: Custom smp_ops for 98DX4251

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   4 +
 arch/arm/boot/dts/rd-dxbc2.dts                     | 118 +++++++++++++++++++++
 arch/arm/mach-mvebu/Makefile                       |   1 +
 arch/arm/mach-mvebu/board-v7.c                     |   7 +-
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |   3 +
 arch/arm/mach-mvebu/platsmp.c                      |  28 +++++
 arch/arm/mach-mvebu/pmsu-98dx4251.c                |  68 ++++++++++++
 drivers/clk/mvebu/armada-xp.c                      |  35 ++++++
 9 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rd-dxbc2.dts
 create mode 100644 arch/arm/mach-mvebu/pmsu-98dx4251.c

-- 
2.2.0.rc0
