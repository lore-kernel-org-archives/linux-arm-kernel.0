From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Tue, 21 May 2013 20:04:04 +0200
Subject: [PATCH v2 0/3] staging: fix parallel display regressions
Message-ID: <1369159448-14584-1-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

Support for VGA via TVE on i.MX53 causes regressions, which prevents
parallel display from working. This series brings the parallel display
functionality back.

The updated series was tested with 3.10-rc2 on a TQMa53 module with
modified device tree.

Markus Niebel (3):
  staging: drm/imx: set correct sync pins for display
  staging: drm/imx: fix spelling error for vsync flag config
  staging: drm/imx: revert vsync_cnt for di->id 1

 drivers/staging/imx-drm/imx-drm-core.c  |    2 +-
 drivers/staging/imx-drm/ipu-v3/ipu-di.c |   13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
1.7.9.5
