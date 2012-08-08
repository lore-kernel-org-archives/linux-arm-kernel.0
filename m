From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Wed, 8 Aug 2012 18:20:57 +0530
Subject: [PATCH v4 0/2] ARM: davinci: add support for dm365 vpbe display
Message-ID: <1344430259-23968-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables VPBE display driver on DM365. 

This patch series is dependent on this patches posted
http://www.spinics.net/lists/arm-kernel/msg188234.html

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

Manjunath Hadli (2):
  ARM: davinci: dm365: add support for v4l2 video display
  ARM: davinci: dm365 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm365-evm.c |  179 +++++++++++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm365.c           |  203 +++++++++++++++++++++++++++++--
 3 files changed, 371 insertions(+), 13 deletions(-)
