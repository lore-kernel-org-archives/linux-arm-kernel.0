From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 19 Oct 2017 14:01:38 +0200
Subject: [PATCH 0/5] ARM: meson: enable gpio interrupt controller
Message-ID: <20171019120143.20581-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables gpio interrupt controller found on the meson SoC
family. ATM, it supports meson8b, gxbb and gxl. The meson8 has been left
out because I don't have the documentation of this particular SoC.

The last patch uses the interrupts provided by this controller with the
external ethernet PHY found on a few platforms.

Jerome Brunet (5):
  ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8b
  ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
  ARM: dts: meson8b: enable gpio interrupt controller
  ARM64: dts: meson-gx: add gpio interrupt controller
  ARM64: dts: meson-gx: add external PHY interrupt on some platforms

 arch/arm/boot/dts/meson.dtsi                         | 9 +++++++++
 arch/arm/boot/dts/meson8b.dtsi                       | 6 ++++++
 arch/arm/mach-meson/Kconfig                          | 1 +
 arch/arm64/Kconfig.platforms                         | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi            | 9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts      | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts       | 2 ++
 12 files changed, 48 insertions(+)

-- 
2.13.6
