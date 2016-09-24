From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 24 Sep 2016 22:26:23 +0800
Subject: [PATCH v2 0/2] Add initial ZTE VOU DRM/KMS driver
Message-ID: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds the initial ZTE VOU display controller DRM/KMS driver.
There are still some features to be added, like overlay plane, scaling,
and more output devices support.  But it's already useful with dual
CRTCs and HDMI monitor working.

Changes for v2:
 - Change device tree bindings to kill the virtual display-subsystem
   node make VOU the parent node.

Shawn Guo (2):
  dt-bindings: add bindings doc for ZTE VOU display controller
  drm: zte: add initial vou drm driver

 .../devicetree/bindings/display/zte,vou.txt        |  86 +++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/zte/Kconfig                        |   8 +
 drivers/gpu/drm/zte/Makefile                       |   8 +
 drivers/gpu/drm/zte/zx_crtc.c                      | 691 +++++++++++++++++++++
 drivers/gpu/drm/zte/zx_crtc.h                      |  47 ++
 drivers/gpu/drm/zte/zx_drm_drv.c                   | 258 ++++++++
 drivers/gpu/drm/zte/zx_drm_drv.h                   |  22 +
 drivers/gpu/drm/zte/zx_hdmi.c                      | 540 ++++++++++++++++
 drivers/gpu/drm/zte/zx_plane.c                     | 362 +++++++++++
 drivers/gpu/drm/zte/zx_plane.h                     |  26 +
 12 files changed, 2051 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
 create mode 100644 drivers/gpu/drm/zte/Kconfig
 create mode 100644 drivers/gpu/drm/zte/Makefile
 create mode 100644 drivers/gpu/drm/zte/zx_crtc.c
 create mode 100644 drivers/gpu/drm/zte/zx_crtc.h
 create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
 create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
 create mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
 create mode 100644 drivers/gpu/drm/zte/zx_plane.c
 create mode 100644 drivers/gpu/drm/zte/zx_plane.h

-- 
1.9.1
