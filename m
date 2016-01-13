From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 13 Jan 2016 16:22:06 +0800
Subject: [PATCH 0/2] drm/rockchip: cleanup unnecessary modules and symbol
Message-ID: <1452673328-29188-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since a67719d (drm/rockchip: vop: spilt register related into
rockchip_reg_vop.c), rockchip_drm_vop's module_init moved to
rockchip_vop_reg.c, then no need to build rockchip_drm_vop.ko

After build rockchip_drm_vop.c into rockchipdrm.ko, following
export symbol is also no needed:
    rockchip_drm_dma_attach_device
    rockchip_drm_dma_detach_device
    rockchip_drm_dma_attach_device
    rockchip_drm_dma_detach_device
    rockchip_register_crtc_funcs
    rockchip_unregister_crtc_funcs
    rockchip_fb_get_gem_obj

Mark Yao (2):
  drm/rockchip: Don't build rockchip_drm_vop as modules
  drm/rockchip: cleanup unnecessary export symbol

 drivers/gpu/drm/rockchip/Makefile           |    5 ++---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    4 ----
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |    1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

-- 
1.7.9.5
