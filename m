From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:49 +0100
Subject: [PATCH v3 00/19] Various Armada 370/XP DT warning fixup
Message-ID: <20161117230508.28539-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As it was done a few months ago for kirkwood, this patchset fixes up
various warning from the DT compiler when using the flag W=1 with
make.

In this third version as request by Rob Herring I removed the '_' sign
in the unit address. I also added a comment in the device tree files
explaining how this unit address was composed.

As for the first two versions, the only remaining warnings are the following:
  DTC     arch/arm/boot/dts/armada-370-db.dtb
Warning (unit_address_vs_reg): Node /sound/simple-audio-card,dai-link at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound/simple-audio-card,dai-link at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound/simple-audio-card,dai-link at 2 has a unit name, but no reg property

However it seems a false positive as here the '@' is part of the name
of the node and is not a reference of an address. Moreover the node
name is directly used by the driver so it must not be modified.

Gregory

Gregory CLEMENT (19):
  ARM: dts: armada-xp-matrix: Fix the location of the pcie-controller
    node
  ARM: dts: armada-370-xp: move the cpurst node in the common file
  ARM: dts: armada-370-xp: add node labels
  ARM: dts: armada-370-xp: Use the node labels
  ARM: dts: armada-370-xp: Fixup mdio DT warning
  ARM: dts: armada-370-xp: Fixup bootrom DT warning
  ARM: dts: armada-370-xp: Fixup devbus DT warning
  ARM: dts: armada-370-xp: Fixup bm-bppi DT warning
  ARM: dts: armada-370-xp: Fixup sa-ram DT warning
  ARM: dts: armada-xp: Fixup pcie DT warnings
  ARM: dts: armada-370: Fixup pcie DT warnings
  ARM: dts: armada-370-xp: Remove skeleton.dtsi
  ARM: dts: armada-370-xp: Fixup l2-cache DT warning
  ARM: dts: armada-370-xp: Fixup internal-regs DT warning
  ARM: dts: armada-370-xp: Fixup soc DT warning
  ARM: dts: armada-370-xp: Fixup memory DT warning
  ARM: dts: armada-370-xp: Remove address from dsa unit name
  ARM: dts: armada-370-xp: Remove button address and fixup names
  ARM: dts: armada-370-xp: Fixup regulator DT warning

 arch/arm/boot/dts/armada-370-db.dts                |  75 +++++----
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  42 +++--
 arch/arm/boot/dts/armada-370-mirabox.dts           |  69 ++++----
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  62 +++----
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  70 ++++----
 arch/arm/boot/dts/armada-370-rd.dts                |  69 ++++----
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |  39 +++--
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  57 ++++---
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |  12 +-
 .../boot/dts/armada-370-seagate-personal-cloud.dts |  12 +-
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  56 ++++---
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  30 ++--
 arch/arm/boot/dts/armada-370-xp.dtsi               |  56 ++++---
 arch/arm/boot/dts/armada-370.dtsi                  | 160 +++++++++---------
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  80 ++++-----
 arch/arm/boot/dts/armada-xp-db.dts                 | 178 +++++++++++----------
 arch/arm/boot/dts/armada-xp-gp.dts                 | 154 +++++++++---------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  65 ++++----
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  64 ++++----
 arch/arm/boot/dts/armada-xp-matrix.dts             |  32 ++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  24 ++-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  32 ++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  34 ++--
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  79 +++++----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 132 ++++++++-------
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |  87 +++++-----
 arch/arm/boot/dts/armada-xp.dtsi                   | 126 +++++++++------
 27 files changed, 1073 insertions(+), 823 deletions(-)

-- 
2.10.2
