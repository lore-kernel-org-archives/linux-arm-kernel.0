From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 21 Sep 2017 19:14:43 +0200
Subject: [PATCH 0/7] ARM: dts: meson: clean pin offsets
Message-ID: <20170921171450.27407-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series is the device-tree part of the series sent to pinctrl [0]
The present patchset depends on the pinctrl part.

The purpose of this series is to:
1) remove the hardcoded gpio offset
2) adjust gpio-ranges with respect to the new pin number of each
   controller
3) adjust gpio-line-names accordingly for the boards having this property.

[0]: https://lkml.kernel.org/r/20170918134610.17743-1-jbrunet at baylibre.com

Jerome Brunet (7):
  ARM: dts: meson8: remove gpio offset
  ARM64: dts: meson-gx: remove gpio offset
  ARM64: dts: meson-gx: adjust gpio-ranges for TEST_N
  ARM64: dts: meson-gxbb: adjust nanopi-k2 gpio-line-names
  ARM64: dts: meson-gxbb: adjust odroid-c2 gpio-line-names
  ARM64: dts: meson-gxl: adjust kvim gpio-line-names
  ARM64: dts: meson-gxl: adjust libretech-cc gpio-line-names

 arch/arm/boot/dts/meson8.dtsi                                |  2 +-
 arch/arm/boot/dts/meson8b.dtsi                               |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   |  8 ++++----
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |  8 ++++----
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   |  2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.13.5
