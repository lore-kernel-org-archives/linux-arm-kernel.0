From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:04:31 +0200
Subject: [PATCH 0/7] i.MX53 IPU + TVE patches
Message-ID: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following patches allow to use the integrated Television Encoder
(TVEv2) on the i.MX53 SoC as VGA output encoder for the IPU. This is
useful for the Freescale i.MX53-QSB and TQ MBa53 boards, which have
VGA and DVI-I connectors, respectively.

regards
Philipp

---
 drivers/staging/imx-drm/Kconfig             |   7 +
 drivers/staging/imx-drm/Makefile            |   1 +
 drivers/staging/imx-drm/imx-drm-core.c      |  15 +-
 drivers/staging/imx-drm/imx-drm.h           |  14 +-
 drivers/staging/imx-drm/imx-tve.c           | 755 ++++++++++++++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |   3 +
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c     |  55 +-
 drivers/staging/imx-drm/ipu-v3/ipu-di.c     | 100 +++-
 drivers/staging/imx-drm/ipuv3-crtc.c        |  11 +-
 9 files changed, 932 insertions(+), 29 deletions(-)
