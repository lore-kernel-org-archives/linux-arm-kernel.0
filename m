From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 May 2014 10:24:53 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC r7s72100-ccf Updates
 for v3.16
Message-ID: <cover.1400289483.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Second Round of
Renesas ARM Based SoC r7s72100 CCF Updates for v3.16.

This pull request is based on the previous round of
such requests, tagged as renesas-r7s72100-ccf-for-v3.16,
which I have already sent a pull-request for.

This comprehensively addresses an oversight in patches included in
the pull request that it depends on, specifically leaving broken
non-multiplatform support in place for genmai-reference.

This pull request has some minor conflicts with other DT changes which I
have previously sent pull requests for. These conflicts are in
arch/arm/boot/dts/Makefile. A resolution can be found in the
renesas-next-v3.15-rc1-20140517 tag if my renesas tree. In words:

    CONFIG_ARCH_SHMOBILE_LEGACY hunk:
    * Remove emev2-kzm9d.dtb
    * Remove r7s72100-genmai-reference.dtb
    * Keep r7s72100-genmai.dtb

    CONFIG_ARCH_SHMOBILE_MULTI hunk:
    * Remove r7s72100-genmai-reference.dtb
    * Keep r7s72100-genmai.dtb
    * Keep r8a7791-henninger.dtb



The following changes since commit 9fbb1ae01b878e2cce9626fa6fdc9e5dcefeb6b5:

  ARM: shmobile: r7s72100: use workaround for non DT-clocks (2014-05-14 11:42:55 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r7s72100-ccf2-for-v3.16

for you to fetch changes up to a5176e0d9de31a54e08468f21c15dc08e006857f:

  ARM: shmobile: Remove Genmai reference DTS (2014-05-17 09:06:29 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC r7s72100 CCF Updates for v3.16

r7s72100 (RZ/A1H) SoC based Genmai board
* Remove non-multiplatform support from genmai-reference

----------------------------------------------------------------
Wolfram Sang (5):
      ARM: shmobile: Remove non-multiplatform Genmai reference support
      ARM: shmobile: genmai-reference: Remove legacy clock support
      ARM: shmobile: Sync Genmai DTS with Genmai reference DTS
      ARM: shmobile: Let Genmai multiplatform boot with Genmai DTB
      ARM: shmobile: Remove Genmai reference DTS

 arch/arm/boot/dts/Makefile                      |  3 +-
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 59 -------------------------
 arch/arm/boot/dts/r7s72100-genmai.dts           | 30 ++++++++++++-
 arch/arm/mach-shmobile/Kconfig                  | 11 -----
 arch/arm/mach-shmobile/Makefile                 |  1 -
 arch/arm/mach-shmobile/Makefile.boot            |  1 -
 arch/arm/mach-shmobile/board-genmai-reference.c |  8 +---
 7 files changed, 31 insertions(+), 82 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r7s72100-genmai-reference.dts
