From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Sep 2016 23:01:14 +0200
Subject: [GIT PULL] Allwinner DRM changes for 4.9
Message-ID: <20160911210114.GA16376@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Please pull the following patches for the next merge window.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-for-4.9

for you to fetch changes up to 0c3ff44cc23cbede56aa1ca5916b126e681ca69b:

  drm/sun4i: add missing header dependencies (2016-09-08 14:55:48 +0200)

----------------------------------------------------------------
Allwinner DRM changes for 4.9

This tag adds the support of a new SoC to sun4i-drm (the Allwinner A33),
and the usual few fixes and enhancements

----------------------------------------------------------------
Baoyou Xie (1):
      drm/sun4i: add missing header dependencies

Chen-Yu Tsai (1):
      drm/sun4i: Clear encoder->bridge if a bridge is not found

Jonathan Liu (1):
      drm/sun4i: rgb: add missing calls to drm_panel_{prepare,unprepare}

Maxime Ripard (7):
      drm/sun4i: Store TCON's device structure pointer
      drm/sun4i: Move panel retrieval in RGB connector
      drm/sun4i: Add bridge support
      drm/sun4i: support TCONs without channel 1
      drm/sun4i: support A33 tcon
      drm/sun4i: backend: Handle the SAT
      drm/sun4i: Add a DRC driver

Wei Yongjun (1):
      drm/sun4i: Remove redundant dev_err call in sun4i_tcon_init_regmap()

 .../bindings/display/sunxi/sun4i-drm.txt           |  43 +++++++-
 drivers/gpu/drm/sun4i/Makefile                     |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |  61 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h              |   3 +
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  12 ++-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |   1 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |  71 ++++++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  98 ++++++++++++-----
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   6 ++
 drivers/gpu/drm/sun4i/sun6i_drc.c                  | 118 +++++++++++++++++++++
 11 files changed, 365 insertions(+), 51 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_drc.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160911/3ab18d55/attachment.sig>
