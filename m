From: john@metanate.com (John Keeping)
Date: Tue, 19 Jan 2016 10:46:57 +0000
Subject: [PATCH v2 0/3] drm/rockchip: fix cursor performance with atomic
In-Reply-To: <cover.1452782114.git.john@metanate.com>
References: <cover.1452782114.git.john@metanate.com>
Message-ID: <cover.1453200263.git.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first two patches are unchanged since v1 but the comment in the
third has been expanded following Thierry's comments.

John Keeping (3):
  drm/atomic-helper: Export framebuffer_changed()
  drm/rockchip: don't wait for vblank if fb hasn't changed
  drm/rockchip: explain why we can't wait_for_vblanks

 drivers/gpu/drm/drm_atomic_helper.c        | 24 ++++++++++++++++++++----
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 23 +++++++++++++++++++++--
 include/drm/drm_atomic_helper.h            |  4 ++++
 3 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.7.0.226.gfe986fe
