From: prabhakar.csengg@gmail.com (Prabhakar lad)
Date: Fri, 22 Mar 2013 13:23:11 +0530
Subject: [PATCH 0/2] davinci: vpss: clock cleanup
Message-ID: <1363938793-22246-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch series cleanup's the VPSS clock enabling.
The first patch removes vpss clock enabling from the capture
drivers and moves it to the VPSS driver itself.
The second patch moves the venc_enable_vpss_clock() to the driver
which was being done in platform code.

Lad, Prabhakar (2):
  media: davinci: vpss: enable vpss clocks
  media: davinci: vpbe: venc: move the enabling of vpss clocks to
    driver

 arch/arm/mach-davinci/dm355.c                |    3 -
 arch/arm/mach-davinci/dm365.c                |    9 +++-
 arch/arm/mach-davinci/dm644x.c               |    5 --
 drivers/media/platform/davinci/dm355_ccdc.c  |   39 +----------------
 drivers/media/platform/davinci/dm644x_ccdc.c |   44 -------------------
 drivers/media/platform/davinci/isif.c        |   28 ++----------
 drivers/media/platform/davinci/vpbe_venc.c   |   26 +++++++++++
 drivers/media/platform/davinci/vpss.c        |   60 ++++++++++++++++++++++++++
 8 files changed, 98 insertions(+), 116 deletions(-)

-- 
1.7.4.1
