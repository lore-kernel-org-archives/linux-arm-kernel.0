From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  1 Feb 2018 13:55:08 +0100
Subject: [PATCH 0/5 v2] PL111 Integrator and Versatile support
Message-ID: <20180201125513.5482-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the old ARM Reference Designs Integrator and Versatile
to be supported by the PL111 driver so we can migrate them
away from fbdev.

Some patches were sent before, some dropped, but I named them
all v2 for consistency and to avoid confusion.

Linus Walleij (5):
  drm/pl111: Properly detect the ARM PL110 variants
  drm/pl111: Handle the Versatile RGB/BGR565 mode
  drm/pl111: Support variants with broken clock divider
  drm/pl111: Support variants with broken VBLANK
  drm/pl111: Support multiple endpoints on the CLCD

 drivers/gpu/drm/pl111/pl111_display.c   |  29 ++++++--
 drivers/gpu/drm/pl111/pl111_drm.h       |   8 +++
 drivers/gpu/drm/pl111/pl111_drv.c       | 118 +++++++++++++++++++++-----------
 drivers/gpu/drm/pl111/pl111_versatile.c |  87 ++++++++++++++++++-----
 4 files changed, 178 insertions(+), 64 deletions(-)

-- 
2.14.3
