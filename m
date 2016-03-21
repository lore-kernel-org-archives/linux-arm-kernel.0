From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 21 Mar 2016 17:28:38 +0800
Subject: [RFC PATCH v1 0/4] Add Rockchip RGA support
Message-ID: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Mark and all.

This patch set would add the RGA direct rendering based 2d graphics
acceleration module.

This patch set is based on git repository below:
git://people.freedesktop.org/~airlied/linux drm-next
commit id: 568d7c764ae01f3706085ac8f0d8a8ac7e826bd7

And the RGA driver is based on Exynos G2D driver, it only manages the
command lists received from user, so user should make the command list
to data and registers needed by operation to use.

I have prepared an userspace demo application for testing:
	https://github.com/yakir-Yang/libdrm-rockchip
That is a rockchip libdrm library, and I have write a simple test case
"rockchip_rga_test" that would test the below RGA features:
- solid
- copy
- rotation
- flip
- window clip
- dithering

Thanks,
- Yakir


Yakir Yang (4):
  drm: rockchip: add a common subdrv interfaces
  drm: rockchip: add RGA driver support
  ARM: dts: rockchip: add RGA device node for RK3288
  ARM: dst: rockchip: enable RGA support on veyron devices

 .../bindings/display/rockchip/rockchip-rga.txt     |  36 +
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   4 +
 arch/arm/boot/dts/rk3288.dtsi                      |  13 +
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  82 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |  19 +
 drivers/gpu/drm/rockchip/rockchip_drm_rga.c        | 977 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_rga.h        | 108 +++
 include/uapi/drm/rockchip_drm.h                    |  63 ++
 10 files changed, 1312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rga.txt
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_rga.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_rga.h
 create mode 100644 include/uapi/drm/rockchip_drm.h

-- 
1.9.1
