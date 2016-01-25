From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 25 Jan 2016 11:54:07 +0100
Subject: [PATCH 1/2] drm/rockchip: Don't build rockchip_drm_vop as modules
In-Reply-To: <1452673328-29188-2-git-send-email-mark.yao@rock-chips.com>
References: <1452673328-29188-1-git-send-email-mark.yao@rock-chips.com>
 <1452673328-29188-2-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1453719247.30130.22.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-13 at 16:22 +0800, Mark Yao wrote:
> rockchip_drm_vop's module init had moved to rockchip_vop_reg.c
> so no need to build rockchip_drm_vop.ko

Looks like this didn't make it for the Linux 4.5 merge window, which
unfortunately means in 4.5-rc1 DRM on rockchip is broken :/

> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> ?drivers/gpu/drm/rockchip/Makefile |????5 ++---
> ?1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Makefile
> b/drivers/gpu/drm/rockchip/Makefile
> index a9d380f..9e6e992 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -3,9 +3,8 @@
> ?# Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> ?
> ?rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o
> rockchip_drm_fbdev.o \
> -		rockchip_drm_gem.o
> +		rockchip_drm_gem.o rockchip_drm_vop.o
> ?
> ?obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
> ?
> -obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_drm_vop.o \
> -				rockchip_vop_reg.o
> +obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_vop_reg.o

-- 
Sjoerd Simons
Collabora Ltd.
