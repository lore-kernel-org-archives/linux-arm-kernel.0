From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 18:16:22 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Clock Updates for
 v3.17
Message-ID: <cover.1405398284.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC clock updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-clock-for-v3.17,
which you have already pulled into next/soc.

CCF support for the SoCs in question is being worked on,
so I expect this code to be a temporary measure.


The following changes since commit edc8fb1d6ebdfc4efa009073586d3567c3368475:

  ARM: shmobile: Fix device node reference leakage in shmobile_init_delay (2014-06-16 19:52:00 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock2-for-v3.17

for you to fetch changes up to ff4ce48e1f163d945c037c1c90ce12950961d91d:

  ARM: shmobile: sh73a0: add SCI clock support for DT (2014-07-12 15:15:39 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Clock Updates for v3.17

* Add legacy clocks for SCI for SoCs that do not yet have CCF support.
  This is to allow SCI (serial) devices to be enabled using DT and
  will be removed after CCF support is added for each SoC.

----------------------------------------------------------------
Simon Horman (4):
      ARM: shmobile: r8a7778: add SCI clock support for DT
      ARM: shmobile: r8a73a4: add SCI clock support for DT
      ARM: shmobile: r8a7740: correct SCI clock support for DT
      ARM: shmobile: sh73a0: add SCI clock support for DT

 arch/arm/mach-shmobile/clock-r8a73a4.c |  6 ++++++
 arch/arm/mach-shmobile/clock-r8a7740.c | 18 +++++++++---------
 arch/arm/mach-shmobile/clock-r8a7778.c |  6 ++++++
 arch/arm/mach-shmobile/clock-sh73a0.c  |  9 +++++++++
 4 files changed, 30 insertions(+), 9 deletions(-)
