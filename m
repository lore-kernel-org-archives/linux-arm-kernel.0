From: b52261@freescale.com (Jianwei Wang)
Date: Fri, 3 Apr 2015 17:35:55 +0800
Subject: [PATCH v4 0/4] drm/layerscape: Add Freescale DCU DRM driver 
Message-ID: <1428053759-3129-1-git-send-email-b52261@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

@Daniel,
Do you have any other comments for this driver?

@Stefan,
Please help test this driver on vybrid if possible, I have test it on vybrid twr board.

If anyone has any objections, please let me know.

Changed in V4:
-This version doesn't have functionality changed. Just a minor adjustment.

Changed in V3:
- Test driver on Vybrid board and add compatible string
- Remove unused functions
- set default crtc for encoder
- replace legacy functions with atomic help functions
- Set the unique name of the DRM device
- Implement irq handle function for vblank interrupt

Changed in v2:
- Add atomic support
- Modify bindings file
- Rename node for compatibility
- Move platform related code out for compatibility

Added in v1:
- Add support for DCU display controller on the Freescale LS102x SoCs.
- Create a primary plane, a fb created for fbdev, a crtc, a connector for TFT LCD panel, an encoder.


 .../devicetree/bindings/drm/fsl/fsl,dcu.txt        |  50 ++++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/fsl/Kconfig                        |  17 ++
 drivers/gpu/drm/fsl/Makefile                       |   7 +
 drivers/gpu/drm/fsl/fsl_dcu_drm_connector.c        | 194 ++++++++++++
 drivers/gpu/drm/fsl/fsl_dcu_drm_connector.h        |  30 ++
 drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c             | 165 +++++++++++
 drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h             |  26 ++
 drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c              | 329 +++++++++++++++++++++
 drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h              | 210 +++++++++++++
 drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c            |  26 ++
 drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c              |  42 +++
 drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h              |  17 ++
 drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c            | 192 ++++++++++++
 drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h            |  23 ++
 16 files changed, 1331 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/fsl/fsl,dcu.txt
 create mode 100644 drivers/gpu/drm/fsl/Kconfig
 create mode 100644 drivers/gpu/drm/fsl/Makefile
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_connector.c
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_connector.h
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.c
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_crtc.h
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_drv.c
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_drv.h
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_kms.c
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_kms.h
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_plane.c
 create mode 100644 drivers/gpu/drm/fsl/fsl_dcu_drm_plane.h
