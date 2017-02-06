From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Feb 2017 16:47:38 +0000
Subject: [GIT PULL] arch timer updates for v4.11
Message-ID: <1486399662-17601-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

These are the arch timer updates for v4.11. I wasn't sure if you wanted
to pull these or pick them, so I'm sending the full series with all
relevant tags folded in.

I'll send the arm64 documentation and the dts updates separately via
arm64 and arm-soc respectively.

Thanks,
Mark.

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arch-timer/updates

for you to fetch changes up to 96aace83d26887143287428d0361d67cbde38d12:

  arm64: arch_timer: work around Hisilicon erratum 161010101 (2017-02-06 16:27:08 +0000)

----------------------------------------------------------------
Ding Tianhong (4):
      arm64: arch_timer: add dt binding for hisilicon-161010101 erratum
      arm64: arm_arch_timer: remove fsl-a008585 parameter
      arm64: arch_timer: introduce generic errata handling infrastructure
      arm64: arch_timer: work around Hisilicon erratum 161010101

 Documentation/admin-guide/kernel-parameters.txt    |   9 --
 .../devicetree/bindings/arm/arch_timer.txt         |   6 +
 arch/arm64/include/asm/arch_timer.h                |  38 ++----
 drivers/clocksource/Kconfig                        |  14 ++
 drivers/clocksource/arm_arch_timer.c               | 151 +++++++++++++++------
 5 files changed, 143 insertions(+), 75 deletions(-)
