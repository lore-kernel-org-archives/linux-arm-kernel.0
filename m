From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Nov 2012 23:23:43 +0100
Subject: [GIT PULL] SMP support for Armada XP
Message-ID: <50AC02EF.20809@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

here it is the patch set for the Armada XP SMP support.
The 4th pacth received the acked-by from Catalin Marinas and the
reviewed-by from Will Deacon.

Thanks

The following changes since commit 1611f872513735ac7105535689c0dd668fbf1c04:

  ARM: Kirkwood: switch to DT clock providers (2012-11-20 14:46:50 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-armadaxp-smp-for-3.8

for you to fetch changes up to e09155559cf88116436c82057a40a9bc64d88c81:

  arm: mvebu: Added SMP support for Armada XP (2012-11-20 18:58:28 +0100)

----------------------------------------------------------------
SMP support for Armada XP

The purpose of this series is to add the SMP support for the Armada XP
SoCs. Beside the SMP support itself brought by the last 3 commits,
this series also adds the support for the coherency fabric unit and
the power management service unit.

The coherency fabric is responsible for ensuring hardware coherency
between all CPUs and between CPUs and I/O masters. This unit is also
available for Armada 370 and will be used in an incoming patch set
for hardware I/O cache coherency.

The power management service unit is responsible for powering down and
waking up CPUs and other SOC units.

----------------------------------------------------------------
Yehuda Yitschak (5):
      arm: mvebu: Added support for coherency fabric in mach-mvebu
      arm: mvebu: Added initial support for power managmement service unit
      arm: mvebu: Added IPI support via doorbells
      arm: mm: Added support for PJ4B cpu and init routines
      arm: mvebu: Added SMP support for Armada XP

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   12 +-
 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 ++++
 .../devicetree/bindings/arm/coherency-fabric.txt   |   16 +++
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    8 +-
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/mach-mvebu/Kconfig                        |    3 +-
 arch/arm/mach-mvebu/Makefile                       |    4 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    3 +
 arch/arm/mach-mvebu/armada-370-xp.h                |    7 ++
 arch/arm/mach-mvebu/coherency.c                    |   80 +++++++++++++
 arch/arm/mach-mvebu/coherency.h                    |   24 ++++
 arch/arm/mach-mvebu/coherency_ll.S                 |   47 ++++++++
 arch/arm/mach-mvebu/common.h                       |    6 +
 arch/arm/mach-mvebu/headsmp.S                      |   50 ++++++++
 arch/arm/mach-mvebu/hotplug.c                      |   30 +++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |   92 ++++++++++++++-
 arch/arm/mach-mvebu/platsmp.c                      |  121 ++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.c                         |   75 ++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   16 +++
 arch/arm/mm/Kconfig                                |    4 +
 arch/arm/mm/proc-v7.S                              |   66 +++++++++++
 22 files changed, 680 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/coherency-fabric.txt
 create mode 100644 arch/arm/mach-mvebu/coherency.c
 create mode 100644 arch/arm/mach-mvebu/coherency.h
 create mode 100644 arch/arm/mach-mvebu/coherency_ll.S
 create mode 100644 arch/arm/mach-mvebu/headsmp.S
 create mode 100644 arch/arm/mach-mvebu/hotplug.c
 create mode 100644 arch/arm/mach-mvebu/platsmp.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.h
