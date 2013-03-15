From: prabhakar.csengg@gmail.com (Prabhakar lad)
Date: Fri, 15 Mar 2013 20:41:41 +0530
Subject: [PATCH v6 0/2] ARM: davinci: add support for dm365 vpbe display
Message-ID: <1363360303-15521-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch series enables VPBE display driver on DM365.

This patch is work on on following pull request from Hans
http://davinci-linux-open-source.1494791.n2.nabble.com/GIT-PULL-FOR-v3-10-tvp7002-davinci-blackfin-legacy-cleanups-td7582451.html

Changes for v6:
1: Fixed review comments pointed by Sekhar.

Changes for v5:
1: pass different platform names to handle different ip's.
2: Fixed review comments pointed by Sekhar.

Changes for v4:
1: Replaced the obsolete preset API by timings API.

Changes for v3:
1: Removed VPSS clock alias for master and slave which was
   sent for VPSS driver. since this patch was dependent on
   patch[1]. I will revist this patch once MC(captrure driver)
   goes into mainline.
[1] http://www.spinics.net/lists/linux-media/msg50562.html

Changes for v2:
1: Added VPSS clock so that capture and display
   can work independent.

Lad, Prabhakar (2):
  ARM: davinci: dm365: add support for v4l2 video display
  ARM: davinci: dm365 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm365-evm.c |  166 +++++++++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm365.c           |  203 +++++++++++++++++++++++++++++--
 3 files changed, 357 insertions(+), 14 deletions(-)

-- 
1.7.4.1
