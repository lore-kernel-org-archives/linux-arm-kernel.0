From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 14:23:57 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a7740 CCF and Timers Updates for
 v3.18
Message-ID: <cover.1409030383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a7740 CCF and timers updates
for v3.18.

These changes are in their own branch as there are SoC and board changes
that depend on DT changes, the reverse of the usual branch dependencies.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a7740-ccf-and-timers-for-v3.18

for you to fetch changes up to 433306747791845677ba662435a9bbbafaa21df3:

  ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt (2014-08-23 19:58:57 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC R8a7740 CCF and Timers Updates for v3.18

When booting using the r8a7740/armadillo800eva using dt-reference:
* Use CCF to initialise clocks via DT
* Initialise timers via DT

----------------------------------------------------------------
Simon Horman (4):
      ARM: shmobile: r8a7740: Add CMT1 device to DT
      ARM: shmobile: armadillo800eva-reference: Enable CMT1 in device tree
      ARM: shmobile: armadillo800eva-reference: Do not use r8a7740_add_standard_devices_dt()
      ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt

Ulrich Hecht (4):
      ARM: shmobile: r8a7740: clock register bits
      ARM: shmobile: r8a7740: add SoC clocks to DTS
      ARM: shmobile: r8a7740: add MSTP clock assignments to DT
      ARM: shmobile: armadillo800eva-reference: add clock overrides to DTS

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  17 ++
 arch/arm/boot/dts/r8a7740.dtsi                     | 220 ++++++++++++++++++++-
 .../board-armadillo800eva-reference.c              |   3 +-
 arch/arm/mach-shmobile/r8a7740.h                   |   1 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |  18 +-
 include/dt-bindings/clock/r8a7740-clock.h          |  77 ++++++++
 6 files changed, 317 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/clock/r8a7740-clock.h
