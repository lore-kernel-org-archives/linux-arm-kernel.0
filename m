From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Jul 2014 08:11:19 -0400
Subject: [GIT PULL V2] ARM: mvebu: SoC changes for v3.17
In-Reply-To: <20140627124655.GF23978@titan.lakedaemon.net>
References: <20140627124655.GF23978@titan.lakedaemon.net>
Message-ID: <20140701121119.GD23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's most of the SoC changes for mvebu so far.  It's looking to be a
slow cycle for us this time around (famous last words ;-) ).

The only unusual item here is the setup file for the kirkwood netxbig
board.  Andrew is working on a DT binding for the LEDs, but it is
non-trivial.  By accepting this now, we can delete mach-kirkwood/, which
is a good thing. :)  I hope to see patches from Andrew on this soon.

As usual, based on v3.16-rc1, no dependencies, been in -next several
days.

Changes for V2: move three patches out of mvebu/soc and into mvebu/fixes
for inclusion in v3.16.

Please pull.

thx,

Jason.

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17

for you to fetch changes up to e65714740d65237c40878b63acad6bf921481974:

  ARM: mvebu: Staticize mvebu_cpu_reset_init (2014-06-30 17:41:04 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.17

 - kirkwood
    - add setup file for netxbig LEDs (non-trivial DT binding doesn't exist yet)

 - mvebu
    - staticize where needed
    - add CPU hotplug for Armada XP
    - add public datasheet for Armada 370
    - don't apply thermal quirk by default
    - get SoC ID from the system controller when possible

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Add setup file for netxbig LEDs

Ezequiel Garcia (1):
      ARM: mvebu: Don't apply the thermal quirk if the SoC revision is unknown

Gregory CLEMENT (2):
      ARM: mvebu: Use the a standard errno in mvebu_get_soc_id
      ARM: mvebu: Use system controller to get the soc id when possible

Sachin Kamat (3):
      ARM: mvebu: Staticize armada_375_smp_cpu1_enable_wa
      ARM: mvebu: Staticize armada_370_xp_cpu_pm_init
      ARM: mvebu: Staticize mvebu_cpu_reset_init

Thomas Petazzoni (6):
      ARM: mvebu: mark armada_370_xp_pmsu_idle_prepare() as static
      ARM: mvebu: remove stub implementation of CPU hotplug on Armada 375/38x
      ARM: mvebu: slightly refactor/rename PMSU idle related functions
      ARM: mvebu: export PMSU idle enter/exit functions
      ARM: mvebu: implement CPU hotplug support for Armada XP
      Documentation: arm: add URLs to public datasheets for the Marvell Armada 370 SoC

 Documentation/arm/Marvell/README        |   4 +-
 arch/arm/mach-mvebu/Kconfig             |   7 ++
 arch/arm/mach-mvebu/Makefile            |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.h     |   3 +
 arch/arm/mach-mvebu/board-v7.c          |  13 ++-
 arch/arm/mach-mvebu/board.h             |   5 +
 arch/arm/mach-mvebu/common.h            |   3 +-
 arch/arm/mach-mvebu/cpu-reset.c         |   2 +-
 arch/arm/mach-mvebu/hotplug.c           |  31 ------
 arch/arm/mach-mvebu/kirkwood.c          |   3 +
 arch/arm/mach-mvebu/mvebu-soc-id.c      |  21 +++-
 arch/arm/mach-mvebu/netxbig.c           | 191 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/platsmp-a9.c        |   5 +-
 arch/arm/mach-mvebu/platsmp.c           |  48 ++++++++
 arch/arm/mach-mvebu/pmsu.c              |  17 +--
 arch/arm/mach-mvebu/system-controller.c |  19 ++++
 16 files changed, 319 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/hotplug.c
 create mode 100644 arch/arm/mach-mvebu/netxbig.c
