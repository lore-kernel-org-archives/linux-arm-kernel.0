From: list-09_linuc_arm@tqsc.de (Markus Niebel)
Date: Fri, 17 May 2013 11:19:50 +0200
Subject: [PATCH 0/3] staging: fix parallel display regressions
Message-ID: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

Support for VGA via TVE on iMX53 causes  regression, which prevents
parallel display from working. This series brings the parallel display
functionality back.

Tested on a modified v3.9 with TQMa53 module and compile tested with
v3.10-rc1.

Markus Niebel (3):
  staging: drm/imx: set correct sync pins for parallel display
  staging: drm/imx: fix spelling error for vsync flag config
  staging: drm/imx: revert vsync_cnt for di->id 1

 drivers/staging/imx-drm/ipu-v3/ipu-di.c    |   13 +++++++++----
 drivers/staging/imx-drm/parallel-display.c |    4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
1.7.9.5
