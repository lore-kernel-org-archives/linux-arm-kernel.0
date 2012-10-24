From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Oct 2012 10:03:59 +0200
Subject: [PATCH 0/2] Add hardware I/O coherency support for Armada 370/XP
Message-ID: <1351065841-18654-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The purpose of this patch set is to add hardware I/O Coherency support
for Armada 370 and Armada XP. Theses SoCs come with an unit called
coherency fabric. A beginning of the support for this unit have been
introduced with the SMP patch set. This series extend this support:
the coherency fabric unit allows to use the Armada XP and the Armada
370 as nearly coherent architectures.

The second patches enables this new feature and register our own set
of DMA ops, to benefit this hardware enhancement.

The first patch introduces a new flag for the address decoding
configuration in order to be able to set the memory windows as
shared memory.

This series depend on the SMP patch set posted on Monday
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/194901).

Regards,

Gregory

Gregory CLEMENT (2):
  arm: plat-orion: Add coherency attribute when setup mbus target
  arm: mvebu: Add hardware I/O Coherency support

 arch/arm/boot/dts/armada-370-xp.dtsi        |    3 +-
 arch/arm/mach-mvebu/addr-map.c              |    3 +
 arch/arm/mach-mvebu/armada-370-xp.c         |    1 +
 arch/arm/mach-mvebu/coherency.c             |   87 +++++++++++++++++++++++++++
 arch/arm/mach-mvebu/common.h                |    2 +
 arch/arm/plat-orion/addr-map.c              |    4 ++
 arch/arm/plat-orion/include/plat/addr-map.h |    1 +
 7 files changed, 100 insertions(+), 1 deletion(-)

-- 
1.7.9.5
