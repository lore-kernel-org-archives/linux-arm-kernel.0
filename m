From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 15:45:00 +0900
Subject: [GIT PULL] Renesas ARM based SoC pinmux fix for v3.10 (repost)
Message-ID: <1369464301-22539-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Repost after hopefully resolving a local mail configuration problem ]

Hi Olof, Hi Arnd,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-fixes2-for-v3.10

for you to fetch changes up to 16a31ebde0763580ed6891094249e1bd4a329be1:

  sh-pfc: r8a7779: Don't group USB OVC and PENC pins (2013-05-22 22:01:59 +0900)

----------------------------------------------------------------
Correction to USB OVC and PENC pin groupings on r8a7779 SoC.
This avoids conflicts when the USB_OVCn pins are used by another function.
This has been observed to be a problem in v3.10-rc1.

----------------------------------------------------------------
Laurent Pinchart (1):
      sh-pfc: r8a7779: Don't group USB OVC and PENC pins

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   45 +++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)
