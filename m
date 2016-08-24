From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 11:25:20 +0900
Subject: [PATCH v2 0/4] ARM: dts: exynos: Enable HDMI in Arndale Octa board
Message-ID: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set enables HDMI in Arndale Octa board and fixes HPD DT property.
It also includes code refactoring on ddc and phy.

v2:
  Include DRM and Exynos maintainers and resend the patch-set.
  Add Rob's ack for the patch,
	[PATCH 2/4] ARM: dts: exynos: Use 'hpd-gpios' instead of 'hpd-gpio'

Milo Kim (4):
  ARM: dts: exynos: Enable HDMI for Arndale Octa board
  ARM: dts: exynos: Use 'hpd-gpios' instead of 'hpd-gpio'
  gpu: drm: exynos_hdmi: Use consolidated function on binding DDC DT
    property
  gpu: drm: exynos_hdmi: Use consolidated function on binding PHY DT
    property

 .../bindings/display/exynos/exynos_hdmi.txt        |  4 +--
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  2 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |  2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  2 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 17 +++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               | 41 ++++++++++++----------
 13 files changed, 52 insertions(+), 30 deletions(-)

-- 
1.9.1
