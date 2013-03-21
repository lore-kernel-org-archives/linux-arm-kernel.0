From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 21 Mar 2013 17:26:13 +0100
Subject: [PATCH 0/5] arm: mvebu: Enable LPAE support for Armada XP SoCs
Message-ID: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The Armada XP SoCs have LPAE support. This patch set allow to run
kernel on this SoCs with LPAE support.

The biggest changes are the conversion of the device tree file to 64
bits in order to be able to use more than 4GB of memory (without this
the LPAE is pointless).

This patch set have been tested on a Armada XP GP board with 8GB of
DRAM with LPAE selected. It have been tested on Armada XP DB board
with 3GB of DRAM with and without LPAE. And also on the Armada 370 DB
board (without LPAE) to check that no regression appeared.

This patch set is based on 3.9-rc3 and is 3.10 material. The
git branch called lpae is available at:
https://github.com/MISL-EBU-System-SW/mainline-public.git.

Thanks,

Gregory CLEMENT (1):
  arm: dts: Convert mvebu device tree files to 64 bits

Lior Amsalem (4):
  arm: mvebu: Aligne the internal registers virtual base to support
    LPAE
  arm: mvebu: Select DMA_BOUNCE when LPAE is selected in Kconfig
  arm: mvebu: Enable pj4b on LPAE compilations
  arm: dts: Add a 64 bits version of the skeleton device tree

 arch/arm/boot/dts/armada-370-db.dts              |    2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |    2 +-
 arch/arm/boot/dts/armada-370-rd.dts              |    2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi             |   45 +++++++++++-----------
 arch/arm/boot/dts/armada-370.dtsi                |   28 +++++++-------
 arch/arm/boot/dts/armada-xp-db.dts               |    2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               |   14 ++++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         |    6 +--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         |   10 ++---
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         |   10 ++---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    2 +-
 arch/arm/boot/dts/armada-xp.dtsi                 |   34 ++++++++--------
 arch/arm/boot/dts/skeleton64.dtsi                |   13 +++++++
 arch/arm/include/debug/mvebu.S                   |    2 +-
 arch/arm/mach-mvebu/Kconfig                      |    1 +
 arch/arm/mach-mvebu/armada-370-xp.h              |    2 +-
 arch/arm/mm/proc-v7.S                            |    3 +-
 17 files changed, 98 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm/boot/dts/skeleton64.dtsi

-- 
1.7.9.5
