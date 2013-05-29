From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 May 2013 07:28:47 +0900
Subject: [GIT PULL] Renesas ARM based SoC fixes for v3.10
Message-ID: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git 

for you to fetch changes up to c7f413548dce3d25609c12efe963b3e6c8e678f3:

  ARM: shmobile: sh73a0: Update CMT clockevent rating to 80 (2013-05-28 14:46:38 +0900)

----------------------------------------------------------------
Renesas ARM based SoC fixes for v3.10

* Correction to USB OVC and PENC pin groupings on r8a7779 SoC.
  This avoids conflicts when the USB_OVCn pins are used by another function.
  This has been observed to be a problem in v3.10-rc1.

* Update CMT clock rating for sh73a0 SoC to resolve boot failure
  on kzm9g-reference. This resolves a regression between v3.9 and v3.10-rc1.

----------------------------------------------------------------
Laurent Pinchart (1):
      sh-pfc: r8a7779: Don't group USB OVC and PENC pins

Simon Horman (1):
      ARM: shmobile: sh73a0: Update CMT clockevent rating to 80

 arch/arm/mach-shmobile/setup-sh73a0.c |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c  |   45 ++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 10 deletions(-)
