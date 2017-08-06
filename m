From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  6 Aug 2017 10:25:09 +0200
Subject: [PATCH 00/12] constify v4l2_m2m_ops structures
Message-ID: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v4l2_m2m_ops structures are only passed as the only
argument to v4l2_m2m_init, which is declared as const.
Thus the v4l2_m2m_ops structures themselves can be const.

Done with the help of Coccinelle.

---

 drivers/media/platform/exynos-gsc/gsc-m2m.c     |    2 +-
 drivers/media/platform/exynos4-is/fimc-m2m.c    |    2 +-
 drivers/media/platform/m2m-deinterlace.c        |    2 +-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c |    2 +-
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c    |    2 +-
 drivers/media/platform/mx2_emmaprp.c            |    2 +-
 drivers/media/platform/rcar_jpu.c               |    2 +-
 drivers/media/platform/s5p-g2d/g2d.c            |    2 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c   |    2 +-
 drivers/media/platform/sti/delta/delta-v4l2.c   |    2 +-
 drivers/media/platform/ti-vpe/vpe.c             |    2 +-
 drivers/media/platform/vim2m.c                  |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
