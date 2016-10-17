From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 17 Oct 2016 12:44:07 -0300
Subject: [PATCH 0/5] [media] Fix module autoload for media platform drivers
Message-ID: <1476719053-17600-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mauro,

I noticed that module autoload won't be working in a bunch of media
platform drivers because the module alias information is not filled
in the modules. This patch series contains the fixes for them.

Best regards,
Javier


Javier Martinez Canillas (5):
  [media] v4l: vsp1: Fix module autoload for OF registration
  [media] v4l: rcar-fcp: Fix module autoload for OF registration
  [media] rc: meson-ir: Fix module autoload
  [media] s5p-cec: Fix module autoload
  [media] st-cec: Fix module autoload

 drivers/media/platform/rcar-fcp.c       | 1 +
 drivers/media/platform/vsp1/vsp1_drv.c  | 1 +
 drivers/media/rc/meson-ir.c             | 1 +
 drivers/staging/media/s5p-cec/s5p_cec.c | 1 +
 drivers/staging/media/st-cec/stih-cec.c | 1 +
 5 files changed, 5 insertions(+)

-- 
2.7.4
