From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Sep 2012 10:07:46 +0200
Subject: [PATCH] Add i.MX IPUv3 base/KMS driver to the staging tree
Message-ID: <1348214872-28594-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following adds the i.MX IPUv3 base and KMS driver to the staging
tree. The patches apply cleanly on next-20120921. Dave has merged the
missing helper functions, so this series has no further dependencies.

Greg, please apply this for staging.

Thanks,
  Sascha

The following changes since commit d2711cb78d2533e66d1172a917391502ce3ddd85:

  Add linux-next specific files for 20120921 (2012-09-21 16:51:19 +1000)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-ipu-staging

for you to fetch changes up to 2d1cf926a36f3e4ea71ea115df846d857e755efd:

  staging: drm/imx: Add TODO (2012-09-21 09:58:52 +0200)

----------------------------------------------------------------
Add support to the ARM i.MX5/6 IPUv3 to staging

----------------------------------------------------------------
Philipp Zabel (1):
      staging: drm/imx: Add devicetree binding documentation

Sascha Hauer (5):
      staging: drm/imx: Add i.MX drm core support
      staging: drm/imx: Add parallel display support
      staging: drm/imx: add i.MX IPUv3 base driver
      staging: drm/imx: Add i.MX IPUv3 crtc support
      staging: drm/imx: Add TODO

 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |   41 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/imx-drm/Kconfig                    |   35 +
 drivers/staging/imx-drm/Makefile                   |    9 +
 drivers/staging/imx-drm/TODO                       |   22 +
 drivers/staging/imx-drm/imx-drm-core.c             |  884 +++++++++++++++
 drivers/staging/imx-drm/imx-drm.h                  |   58 +
 drivers/staging/imx-drm/imx-fb.c                   |   47 +
 drivers/staging/imx-drm/imx-fbdev.c                |   74 ++
 drivers/staging/imx-drm/ipu-v3/Makefile            |    3 +
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h        |  318 ++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        | 1143 ++++++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c            |  372 +++++++
 drivers/staging/imx-drm/ipu-v3/ipu-di.c            |  700 ++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c          |  408 +++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dp.c            |  336 ++++++
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h           |  206 ++++
 drivers/staging/imx-drm/ipuv3-crtc.c               |  579 ++++++++++
 drivers/staging/imx-drm/parallel-display.c         |  261 +++++
 20 files changed, 5499 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
 create mode 100644 drivers/staging/imx-drm/Kconfig
 create mode 100644 drivers/staging/imx-drm/Makefile
 create mode 100644 drivers/staging/imx-drm/TODO
 create mode 100644 drivers/staging/imx-drm/imx-drm-core.c
 create mode 100644 drivers/staging/imx-drm/imx-drm.h
 create mode 100644 drivers/staging/imx-drm/imx-fb.c
 create mode 100644 drivers/staging/imx-drm/imx-fbdev.c
 create mode 100644 drivers/staging/imx-drm/ipu-v3/Makefile
 create mode 100644 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
 create mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-common.c
 create mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-dc.c
 create mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-di.c
 create mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-dp.c
 create mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-prv.h
 create mode 100644 drivers/staging/imx-drm/ipuv3-crtc.c
 create mode 100644 drivers/staging/imx-drm/parallel-display.c
