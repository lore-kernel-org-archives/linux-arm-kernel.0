From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Sep 2012 12:31:08 +0200
Subject: [PATCH] Add i.MX IPUv3 base/KMS driver to the staging tree
Message-ID: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg et all,

The following adds the i.MX IPUv3 base and KMS driver to the staging
tree. It currently depends on two patches adding helper functions to
the DRM core. Dave Airlie already has signalled he is ok with these
helper functions. Apart from that, please let me know if there's anything
else blocking the IPU patches from going to staging. If not, I would
ping again once the helper patches show up in linux-next.

Thanks
 Sascha


The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/staging-drm-imx

for you to fetch changes up to d344cf816ce270a74d5210d771646ad04c89a7cc:

  staging: drm/imx: Add TODO (2012-09-12 12:01:13 +0200)

----------------------------------------------------------------
This adds an ARM i.MX IPUv3 base and DRM driver to the staging
tree.

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
 drivers/staging/imx-drm/imx-drm-core.c             |  882 +++++++++++++++
 drivers/staging/imx-drm/imx-drm.h                  |   58 +
 drivers/staging/imx-drm/imx-fb.c                   |   47 +
 drivers/staging/imx-drm/imx-fbdev.c                |   74 ++
 drivers/staging/imx-drm/ipu-v3/Makefile            |    3 +
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h        |  318 ++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        | 1143 ++++++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c            |  379 +++++++
 drivers/staging/imx-drm/ipu-v3/ipu-di.c            |  700 ++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c          |  408 +++++++
 drivers/staging/imx-drm/ipu-v3/ipu-dp.c            |  336 ++++++
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h           |  206 ++++
 drivers/staging/imx-drm/ipuv3-crtc.c               |  579 ++++++++++
 drivers/staging/imx-drm/parallel-display.c         |  262 +++++
 20 files changed, 5505 insertions(+)
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
