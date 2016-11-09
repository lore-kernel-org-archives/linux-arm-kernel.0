From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  9 Nov 2016 21:21:52 +0800
Subject: [PATCH v2 0/9] rockchip: add more power domain and devices dts for
 rk3399
Message-ID: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please allow me to integrate these patches.
They are missing or losing for upstream, then there are some patches
are  always depending on them.

The following patches are releated to PD.
git log --oneline
827198c arm64: dts: rockchip: add the usb3 pd for rk3399
95e95b4 arm64: dts: rockchip: support dwc3 USB for rk3399
3ced49c arm64: dts: rockchip: add pd_edp node for rk3399
e19db3f arm64: dts: rockchip: introduce pclk_vio_grf in eDP device node
eb92079 arm64: dts: rockchip: add backlight support for rk3399 evb board
20b8135 arm64: dts: rockchip: add eDP device node for rk3399
480a1bb arm64: dts: rockchip: add VOP and VOP iommu node for rk3399
4964c0a arm64: dts: rockchip: add pd_sd power node for rk3399
c407a4c arm64: dts: rockchip: add eMMC's power domain support for rk3399

----
Hi Heiko & guys,

This series patches support the below PDs.

1) sd & emmc pd
4964c0a arm64: dts: rockchip: add pd_sd power node for rk3399
c407a4c arm64: dts: rockchip: add eMMC's power domain support for rk3399

2) edp pd
3ced49c arm64: dts: rockchip: add pd_edp node for rk3399
e19db3f arm64: dts: rockchip: introduce pclk_vio_grf in eDP device node
eb92079 arm64: dts: rockchip: add backlight support for rk3399 evb board
20b8135 arm64: dts: rockchip: add eDP device node for rk3399
480a1bb arm64: dts: rockchip: add VOP and VOP iommu node for rk3399

3) usb3 pd
827198c arm64: dts: rockchip: add the usb3 pd for rk3399
95e95b4 arm64: dts: rockchip: support dwc3 USB for rk3399

Thanks,
Caesar


Changes in v2:
- Reviewed-on: https://chromium-review.googlesource.com/376558
- Verified on ChromeOS kernel4.4
- v1 on https://patchwork.kernel.org/patch/9322553/
- Reviewed-on: https://chromium-review.googlesource.com/386483
- Verified on ChromeOS kernel4.4
- Yakir posted the original patch on
- https://patchwork.kernel.org/patch/9191777
- the original patches from brian posting on
  https://chromium-review.googlesource.com/343603
- Reviewed-on: https://chromium-review.googlesource.com/384280

Brian Norris (1):
  arm64: dts: rockchip: support dwc3 USB for rk3399

Caesar Wang (1):
  arm64: dts: rockchip: add the usb3 pd for rk3399

Mark Yao (1):
  arm64: dts: rockchip: add VOP and VOP iommu node for rk3399

Yakir Yang (3):
  arm64: dts: rockchip: add eDP device node for rk3399
  arm64: dts: rockchip: add backlight support for rk3399 evb board
  arm64: dts: rockchip: introduce pclk_vio_grf in eDP device node

Ziyuan Xu (1):
  arm64: dts: rockchip: add eMMC's power domain support for rk3399

zhangqing (2):
  arm64: dts: rockchip: add pd_sd power node for rk3399
  arm64: dts: rockchip: add pd_edp node for rk3399

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  40 ++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 210 ++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

-- 
2.7.4
