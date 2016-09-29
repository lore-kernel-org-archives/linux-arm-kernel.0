From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 29 Sep 2016 11:29:47 +0800
Subject: [PATCH 0/2] fix issue: vblank interrupts are never disabled 
Message-ID: <1475119789-64619-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean the interrupt status before enable interrupt
and set the vblank_disable_allowed to fix the issue.

Bibby Hsieh (2):
  drm/mediatek: set vblank_disable_allowed to true
  drm/mediatek: clear IRQ status before enable OVL interrupt

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |    1 +
 2 files changed, 2 insertions(+)

-- 
1.7.9.5
