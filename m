From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  4 Aug 2017 20:08:10 +0200
Subject: [PATCH 0/6] ARM64: dts: meson: update around mmc
Message-ID: <20170804180816.18737-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset feature update around mmc. It is linked to this series [0]
but does not strictly depends on it. It adds:

* The regulator settling times for the gpio regulator of nanopi-k2 and
  the libretech-cc.
* UHS modes for the p20x and nanopi-k2. SDR104 is left out because the
  p20x does not support it and the driver requires more work to enable
  it on the nanopi-k2
* clk-gate pins: these are the pinmuxes used for the clk-stop work
  around explained here [0]

It also removes cap-sd-highspeed from eMMC nodes.

This series has been tested on the gxbb-200, the gxbb-nanopi-k2 and the
gxl-s905x-libretech-cc

Jerome Brunet (6):
  ARM64: dts: meson-gxbb: nanopi-k2: add card regulator settle times
  ARM64: dts: meson-gxl: libretech-cc: add card regulator settle times
  ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
  ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS modes
  ARM64: dts: meson: add mmc clk gate pins
  ARM64: dts: meson: remove cap-sd-highspeed from emmc nodes

 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 10 ++++---
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 18 ++++++++----
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 12 ++++----
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  9 +++---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 13 ++++++---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 10 ++++---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 33 ++++++++++++++++++++++
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  7 +++--
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  9 ++++--
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 10 ++++---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 10 ++++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 33 ++++++++++++++++++++++
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  7 +++--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |  1 -
 14 files changed, 139 insertions(+), 43 deletions(-)

-- 
2.9.4
