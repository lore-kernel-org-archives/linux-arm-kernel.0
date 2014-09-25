From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Thu, 25 Sep 2014 14:33:55 +0530
Subject: [RFC PATCH 0/4] arm64:numa: Add numa support for arm64 platforms.
Message-ID: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is initial patch set to support numa on arm64 based platforms.
Tested these patches on cavium's multinode(2 node topology) simulator.
Tried all test-cases present in numactl-2.0.9 package.

In this patchset, defined dt bindings for numa mapping for memory
nodes. The cpu to node mapping is derived from the existing cpu-map
mapping as defined in topology binding.

thanks,
Ganapat

Ganapatrao Kulkarni (4):
  arm64: defconfig: increase NR_CPUS range to 2-128
  arm/arm64:dt:numa: adding numa node mapping for memory nodes.
  arm64:thunder: Add initial dts for Cavium Thunder SoC in 2 Node topology.
  arm64:numa: adding numa support for arm64 platforms.

 Documentation/devicetree/bindings/arm/numa.txt |  60 ++
 arch/arm64/Kconfig                             |  37 +-
 arch/arm64/boot/dts/thunder-88xx-2n.dts        |  76 ++
 arch/arm64/boot/dts/thunder-88xx-2n.dtsi       | 990 +++++++++++++++++++++++++
 arch/arm64/include/asm/mmzone.h                |  32 +
 arch/arm64/include/asm/numa.h                  |  41 +
 arch/arm64/kernel/setup.c                      |   8 +
 arch/arm64/kernel/smp.c                        |   2 +
 arch/arm64/mm/Makefile                         |   1 +
 arch/arm64/mm/init.c                           |  33 +-
 arch/arm64/mm/numa.c                           | 471 ++++++++++++
 11 files changed, 1745 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
 create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dts
 create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dtsi
 create mode 100644 arch/arm64/include/asm/mmzone.h
 create mode 100644 arch/arm64/include/asm/numa.h
 create mode 100644 arch/arm64/mm/numa.c

-- 
1.8.1.4
