From: john@metanate.com (John Keeping)
Date: Thu, 14 Jan 2016 14:39:39 +0000
Subject: [PATCH 0/3] drm/rockchip: fix cursor performance with atomic
In-Reply-To: <20160114142047.GD19130@phenom.ffwll.local>
References: <20160114142047.GD19130@phenom.ffwll.local>
Message-ID: <cover.1452782114.git.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jan 2016 15:20:47 +0100, Daniel Vetter wrote:

> Ugh. Oh well, there's not really anything we can do in core nore helpers
> to make this easier for drivers. This really only can be fixed sensibly at
> the hardware level.
> 
> So yeah I think exposing framebuffer_changed as a helper is the way to go
> here.

OK, here's a series to do that.  I also added a comment to
rockchip_atomic_wait_for_complete() explaining why we can't use
drm_atomic_helper_wait_for_vblanks().

John Keeping (3):
  drm/atomic-helper: Export framebuffer_changed()
  drm/rockchip: don't wait for vblank if fb hasn't changed
  drm/rockchip: explain why we can't wait_for_vblanks

 drivers/gpu/drm/drm_atomic_helper.c        | 24 ++++++++++++++++++++----
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 14 ++++++++++++--
 include/drm/drm_atomic_helper.h            |  4 ++++
 3 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.7.0.226.gfe986fe
