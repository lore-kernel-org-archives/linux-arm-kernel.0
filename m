From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Fri, 27 Jul 2012 17:50:02 +0530
Subject: [PATCH v3 0/2] ARM: davinci: add support for dm365 vpbe display driver
Message-ID: <1343391604-25578-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables VPBE display driver on DM365.

Changes for v3:
1: Removed VPSS clock alias for master and slave which was
   sent for VPSS driver. since this patch was dependent on
   patch[1]. I will revist this patch once MC(captrure driver)
   goes into mainline.
[1] http://www.spinics.net/lists/linux-media/msg50562.html

Changes for v2:
1: Added VPSS clock so that capture and display
   can work independent.

Manjunath Hadli (2):
  ARM: davinci: dm365: add support for v4l2 video display
  ARM: davinci: dm365 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm365-evm.c |  178 +++++++++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm365.c           |  214 +++++++++++++++++++++++++++++--
 3 files changed, 381 insertions(+), 13 deletions(-)
