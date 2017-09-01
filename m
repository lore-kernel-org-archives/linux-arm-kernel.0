From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  1 Sep 2017 11:36:30 +0200
Subject: [PATCH 0/7 v2] First set of PL111 enhancements
Message-ID: <20170901093637.4041-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the v2 patch set fixing the review comments (hopefully).

Mainly I had to drop the cleverness of wrapping power enablement
inside the panel prepare/enable pair and fall back to a 20ms
delay as in the framebuffer driver. I hope everyone survives
this.

Linus Walleij (7):
  drm/pl111: Cleanup local header file
  drm/pl111: Add all registers to debugfs
  drm/pl111: Replace custom connector with panel bridge
  drm/pl111: Enable PL110 variant
  drm/pl111: Insert delay before powering up PL11x
  drm/pl111: Add optional variant display en/disable callbacks
  drm/pl111: Add handling of Versatile platforms

 drivers/gpu/drm/pl111/Kconfig           |   3 +-
 drivers/gpu/drm/pl111/Makefile          |   4 +-
 drivers/gpu/drm/pl111/pl111_connector.c | 127 ---------------
 drivers/gpu/drm/pl111/pl111_debugfs.c   |   6 +
 drivers/gpu/drm/pl111/pl111_display.c   |  81 +++++-----
 drivers/gpu/drm/pl111/pl111_drm.h       |  38 +++--
 drivers/gpu/drm/pl111/pl111_drv.c       | 156 +++++++++++++++---
 drivers/gpu/drm/pl111/pl111_versatile.c | 270 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_versatile.h |   9 ++
 9 files changed, 489 insertions(+), 205 deletions(-)
 delete mode 100644 drivers/gpu/drm/pl111/pl111_connector.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_versatile.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_versatile.h

-- 
2.13.5
