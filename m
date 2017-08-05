From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  5 Aug 2017 12:47:07 +0200
Subject: [PATCH 0/6] constify vb2_ops structures
Message-ID: <1501930033-18249-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These vb2_ops structures are only stored in the ops field of a
vb2_queue structure, which is declared as const.  Thus the vb2_ops
structures themselves can be const.

Done with the help of Coccinelle.

---

 drivers/media/platform/blackfin/bfin_capture.c                |    2 +-
 drivers/media/platform/davinci/vpbe_display.c                 |    2 +-
 drivers/staging/media/davinci_vpfe/vpfe_video.c               |    2 +-
 drivers/staging/media/imx/imx-media-capture.c                 |    4 ++--
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c |    2 +-
 samples/v4l/v4l2-pci-skeleton.c                               |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
