From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat, 15 Jul 2017 14:58:34 +0800
Subject: [PATCH v2 0/6] Add Rockchip RGA V4l2 support
Message-ID: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add a v4l2 m2m drvier for rockchip RGA direct rendering based 2d graphics acceleration module.

change in V2:
- generalize the controls.
- map buffers (10-50 us) in every cmd-run rather than in buffer-import to avoid get_free_pages failed on
actively used systems.
- remove status in dt-bindings examples.


Jacob Chen (6):
  [media] v4l: add blend modes controls
  [media] rockchip/rga: v4l2 m2m support
  ARM: dts: rockchip: add RGA device node for RK3288
  ARM: dts: rockchip: add RGA device node for RK3399
  ARM: dts: rockchip: enable RGA for rk3288 devices
  dt-bindings: Document the Rockchip RGA bindings

 .../devicetree/bindings/media/rockchip-rga.txt     |  35 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   4 +
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |   4 +
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   4 +
 arch/arm/boot/dts/rk3288-miqi.dts                  |   4 +
 arch/arm/boot/dts/rk3288-popmetal.dts              |   4 +
 arch/arm/boot/dts/rk3288-tinker.dts                |   4 +
 arch/arm/boot/dts/rk3288.dtsi                      |  13 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  13 +
 drivers/media/platform/Kconfig                     |  11 +
 drivers/media/platform/Makefile                    |   2 +
 drivers/media/platform/rockchip-rga/Makefile       |   3 +
 drivers/media/platform/rockchip-rga/rga-buf.c      | 176 ++++
 drivers/media/platform/rockchip-rga/rga-hw.c       | 456 ++++++++++
 drivers/media/platform/rockchip-rga/rga-hw.h       | 434 +++++++++
 drivers/media/platform/rockchip-rga/rga.c          | 979 +++++++++++++++++++++
 drivers/media/platform/rockchip-rga/rga.h          | 133 +++
 drivers/media/v4l2-core/v4l2-ctrls.c               |  19 +
 include/uapi/linux/v4l2-controls.h                 |  18 +-
 19 files changed, 2315 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-rga.txt
 create mode 100644 drivers/media/platform/rockchip-rga/Makefile
 create mode 100644 drivers/media/platform/rockchip-rga/rga-buf.c
 create mode 100644 drivers/media/platform/rockchip-rga/rga-hw.c
 create mode 100644 drivers/media/platform/rockchip-rga/rga-hw.h
 create mode 100644 drivers/media/platform/rockchip-rga/rga.c
 create mode 100644 drivers/media/platform/rockchip-rga/rga.h

-- 
2.7.4
