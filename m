From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  1 Dec 2011 14:58:50 +0100
Subject: [PATCH] video IPUv1 fixes for different display connections
Message-ID: <1322747932-24943-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series fixes the display connections to the IPU on
i.MX3 boards. The connection to the display is completely independend
of the internal pixel format in the framebuffer. The driver instead
changes the IPU <-> Display mapping dependent on the pixelformat
which is wrong.
The following patch makes 16bpp and 32bpp modes possible on both
RGB666 and RGB888 connected displays.
The burstsize setting for 32bpp was configured wrong, so 32bpp
modes have obviously never been tested.

Not for stable since all in kernel boards seem to work.

Sascha Hauer (2):
      i.MX IPU DMA: Fix wrong burstsize settings
      video i.MX IPU: Fix display connections

 arch/arm/plat-mxc/include/mach/mx3fb.h |   15 ++++++++
 drivers/dma/ipu/ipu_idmac.c            |   25 +------------
 drivers/video/mx3fb.c                  |   61 +++++++++++--------------------
 3 files changed, 38 insertions(+), 63 deletions(-)
