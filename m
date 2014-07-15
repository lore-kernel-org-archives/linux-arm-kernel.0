From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 18:16:36 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v3.17
Message-ID: <cover.1405398515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT updates for v3.17.

This pull request is based on a merge of:

* The previous round of such requests, tagged as renesas-dt2-for-v3.17,
  which you have already pulled into next/dt and;
* The second round of Renesas ARM Based SoC Clock Updates for v3.17,
  tagged as renesas-clock2-for-v3.17, which I have send a pull request for.

The reason for the clock update is to provide run-time dependencies
to allow SCI to be initialised on DT on SoCs that do not yet have
CCF support. The key word being yet, it is being worked on.

which I have already sent a pull-request for.


The following changes since commit 963b0c359bf5d284fc597bed07a668cb7396bfd2:

  Merge branch 'clock-for-v3.17' into dt-for-v3.17 (2014-07-12 15:16:37 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.17

for you to fetch changes up to 700ce7c2bb2a4963472d95eba1436d6b0945918e:

  ARM: shmobile: kzm9g-reference: Initialise SCIF device using DT (2014-07-12 15:16:58 +0200)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v3.17

* Initialise SCI using DT when booting the kzm9g, armadillo800eva,
  ape6evm and bockw boards without legacy-C code.

----------------------------------------------------------------
Simon Horman (8):
      ARM: shmobile: r8a7778: Add SCIF nodes
      ARM: shmobile: bockw-reference: Initialise SCIF device using DT
      ARM: shmobile: r8a73a4: Add SCIF nodes
      ARM: shmobile: ape6evm-reference: Initialise SCIF device using DT
      ARM: shmobile: r8a7740: Add SCIF nodes
      ARM: shmobile: armadillo800eva-reference: Initialise SCIF device using DT
      ARM: shmobile: sh73a0: Add SCIF nodes
      ARM: shmobile: kzm9g-reference: Initialise SCIF device using DT

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 14 ++++-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 42 +++++++++++++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 14 ++++-
 arch/arm/boot/dts/r8a7740.dtsi                     | 63 +++++++++++++++++++
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 14 ++++-
 arch/arm/boot/dts/r8a7778.dtsi                     | 42 +++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 14 ++++-
 arch/arm/boot/dts/sh73a0.dtsi                      | 72 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a73a4.c             | 12 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c             |  8 +--
 arch/arm/mach-shmobile/setup-r8a7778.c             | 12 ++--
 arch/arm/mach-shmobile/setup-sh73a0.c              |  8 +--
 12 files changed, 283 insertions(+), 32 deletions(-)
