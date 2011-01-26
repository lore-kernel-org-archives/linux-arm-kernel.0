From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 26 Jan 2011 09:49:47 +0100
Subject: [PATCH 0/2] Fix issues with frame reception from CSI on i.MX31
Message-ID: <1296031789-1721-1-git-send-email-agust@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some camera systems we do not tolerate the losing of
captured frames. We observed losing of the first frame
from CSI when double buffering is used (multiple buffers
queued by the mx3-camera driver).

The patches provide fixes for the observed problem.

Anatolij Gustschin (2):
  v4l: soc-camera: start stream after queueing the buffers
  dma: ipu_idmac: do not lose valid received data in the irq handler

 drivers/dma/ipu/ipu_idmac.c      |   50 --------------------------------------
 drivers/media/video/soc_camera.c |    4 +-
 2 files changed, 2 insertions(+), 52 deletions(-)
