From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Aug 2017 20:07:04 +0200
Subject: [PATCH 0/7] First set of PL111 enhancements
Message-ID: <20170830180711.2791-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

here is the first few patches to enhance the PL111 with the following
objectives:

- Consolidation - use the panel bridge, which I figured out after some
  tinkering (yes I will fix TVE200 too).
- Handle the PL110 variant
- Handle the power-on delay documented in both manuals
- Add callbacks to handle subvariants, and a scratch implementation
  of the Versatile extra register (no Nomadik yet).

Next steps will be (I guess)

- Make the driver also use the dumb VGA connector bridge for the platforms
  that simply connects the PL11x to a DAC to VGA
- Proper panel driver for the Versatile board
- Nomadik and its panel
- When things work, stepwise move the ARM platforms using this over to
  the DRM PL111 driver

Stuff that gets properly reviewed I can queue on drm-misc myself these days.

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
 drivers/gpu/drm/pl111/pl111_display.c   |  82 +++++-----
 drivers/gpu/drm/pl111/pl111_drm.h       |  38 +++--
 drivers/gpu/drm/pl111/pl111_drv.c       | 151 +++++++++++++++---
 drivers/gpu/drm/pl111/pl111_versatile.c | 270 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_versatile.h |   9 ++
 9 files changed, 491 insertions(+), 199 deletions(-)
 delete mode 100644 drivers/gpu/drm/pl111/pl111_connector.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_versatile.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_versatile.h

-- 
2.13.5
