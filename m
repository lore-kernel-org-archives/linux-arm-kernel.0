From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 May 2014 17:34:20 -0700
Subject: [GIT PULL] omap fixes for v3.15 -rc cycle
Message-ID: <20140520003419.GA15793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-v3-signed

for you to fetch changes up to 4b353a706a86598ba47307c47301c3c428b79e09:

  ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled (2014-05-19 11:20:38 -0700)

----------------------------------------------------------------
Regression fixes for omaps for NAND, DMA, cpu_idle and audio.
Also a minor one line fix for audio clock on 54xx.

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5 on all OMAP3 platforms

Peter Ujfalusi (1):
      ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM

Roger Quadros (1):
      ARM: OMAP2+: nand: Fix NAND on OMAP2 and OMAP3 boards

Santosh Shilimkar (1):
      ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled

Tony Lindgren (2):
      Merge tag 'for-v3.15-rc/omap-fixes-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.15/fixes-v3
      ARM: OMAP2+: Fix DMA hang after off-idle

 arch/arm/mach-omap2/board-flash.c          |  2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c      |  3 ++-
 arch/arm/mach-omap2/cpuidle44xx.c          | 25 +++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  2 +-
 arch/arm/plat-omap/dma.c                   | 10 ++++++++++
 5 files changed, 35 insertions(+), 7 deletions(-)
