From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 19:48:24 +0800
Subject: [PATCH v2 0/2] Fixes kernel Oops in imx-drm drivers
Message-ID: <1408967306-2624-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my testing of bind/unbind (and insmod/rmmod) on imx-drm drivers,
a couple of kernel Oops are seen.  These two patches are trying to
fix them.

Changes since v1:
 - Remove function ipu_plane_dpms() completely as suggested by Philipp

Shawn Guo (2):
  imx-drm: imx-ldb: fix kernel Oops in imx_ldb_unbind()
  imx-drm: ipuv3-plane: fix kernel Oops in ipu_dp_put()

 drivers/staging/imx-drm/imx-ldb.c     |  2 ++
 drivers/staging/imx-drm/ipuv3-plane.c | 28 ++++------------------------
 2 files changed, 6 insertions(+), 24 deletions(-)

-- 
1.9.1
