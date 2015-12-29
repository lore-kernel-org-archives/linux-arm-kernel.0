From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 29 Dec 2015 16:02:24 +0530
Subject: [PATCH v8 0/4] arm64, numa: Add numa support for arm64 platforms
Message-ID: <1451385148-13448-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v8:
	- Incorporated review comments of Mark Rutland and Will Deacon.
	- Added pci helper function and macro for numa.

v7:
	- managing numa memory mapping using memblock.
	- Incorporated review comments of Mark Rutland.

v6:
	- defined and implemented the numa dt binding using
	node property proximity and device node distance-map.
	- renamed dt_numa to of_numa

v5:
        - created base verion of numa.c which creates dummy numa without using dt
          on single socket platforms. Then added patches for dt support.
        - Incorporated review comments from Hanjun Guo.

v4:
done changes as per Arnd review comments.

v3:
Added changes to support numa on arm64 based platforms.
Tested these patches on cavium's multinode(2 node topology) platform.
In this patchset, defined and implemented dt bindings for numa mapping
for core and memory using device node property arm,associativity.

v2:
Defined and implemented numa map for memory, cores to node and
proximity distance matrix of nodes.

v1:
Initial patchset to support numa on arm64 platforms.

Note:
        1. This patchset is tested for numa with dt on
           thunderx single socket and dual socket boards.
        2. Numa DT booting needs the dt memory nodes, which are deleted in current efi-stub,
        hence to try numa with dt, you need to rebase with ard's patchset.
        http://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/arm64-uefi-early-fdt-handling

Ganapatrao Kulkarni (4):
  arm64, numa: adding numa support for arm64 platforms.
  Documentation, dt, arm64/arm: dt bindings for numa.
  arm64/arm, numa, dt: adding numa dt binding implementation for arm64
    platforms.
  arm64, dt, thunderx: Add initial dts for Cavium Thunderx in 2 node
    topology.

 Documentation/devicetree/bindings/arm/numa.txt  | 272 ++++++++
 arch/arm64/Kconfig                              |  35 +
 arch/arm64/boot/dts/cavium/Makefile             |   2 +-
 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts  |  83 +++
 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi | 806 ++++++++++++++++++++++++
 arch/arm64/include/asm/mmzone.h                 |  18 +
 arch/arm64/include/asm/numa.h                   |  56 ++
 arch/arm64/kernel/Makefile                      |   1 +
 arch/arm64/kernel/of_numa.c                     | 265 ++++++++
 arch/arm64/kernel/pci.c                         |   9 +
 arch/arm64/kernel/setup.c                       |   4 +
 arch/arm64/kernel/smp.c                         |   4 +
 arch/arm64/mm/Makefile                          |   1 +
 arch/arm64/mm/init.c                            |  31 +-
 arch/arm64/mm/mmu.c                             |   1 +
 arch/arm64/mm/numa.c                            | 395 ++++++++++++
 16 files changed, 1977 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi
 create mode 100644 arch/arm64/include/asm/mmzone.h
 create mode 100644 arch/arm64/include/asm/numa.h
 create mode 100644 arch/arm64/kernel/of_numa.c
 create mode 100644 arch/arm64/mm/numa.c

-- 
1.8.1.4
