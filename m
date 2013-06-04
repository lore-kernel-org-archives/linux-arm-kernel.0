From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Jun 2013 16:46:54 +0900
Subject: [GIT PULL v3] Renesas ARM based SoC fixes for v3.10
Message-ID: <1370332016-16017-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

I have revised this series to include Linus Walleij's ack for
"sh-pfc: r8a7779: Don't group USB OVC and PENC pins" and double
checked that I actually pushed the tag this time.

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v3.10

for you to fetch changes up to 5600a8485603b240790005b9b58de4c4f6ada69d:

  ARM: shmobile: sh73a0: Update CMT clockevent rating to 80 (2013-06-04 14:37:53 +0900)

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

 arch/arm/mach-shmobile/setup-sh73a0.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c  | 45 ++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 10 deletions(-)
