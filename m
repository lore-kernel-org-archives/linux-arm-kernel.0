From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:28 +0200
Subject: [PATCH v2 0/9] ARM64: dts: meson: update around mmc
Message-ID: <20170821160637.22456-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset feature updates around mmc. It is linked to this series [0]
but does not strictly depends on it. It adds:

* The regulator settling times for the gpio regulator of nanopi-k2 and
  the libretech-cc.
* UHS modes for the p20x and nanopi-k2.
* clk-gate pins: these are the pinmuxes used for the clk-stop work
  around explained here [1]

It also removes cap-sd-highspeed from eMMC nodes.

Special note on SDR104:
While the PCB of the p200 and the libretech-cc does not seems to handle
SDR104 completely, the nanopi-k2 seems to be handling it correctly.

The patch enabling this mode on the nanopi-k2 is the last one of this
series. It should propabably be left out until more people can test
sdr104 on the nanopi-k2

This series has been tested on the gxbb-200, the gxbb-nanopi-k2 and the
gxl-s905x-libretech-cc

Changes since v1 [2]:
* Reorder patches to put fixes first, then enhancements
* Fix error in the SDIO clk_gate pins (GPIOX_5 instead GPIOX_4)

[0]: https://lkml.kernel.org/r/20170821160301.21899-1-jbrunet at baylibre.com
[1]: https://lkml.kernel.org/r/20170821160301.21899-11-jbrunet at baylibre.com
[2]: https://lkml.kernel.org/r/20170804180816.18737-1-jbrunet at baylibre.com

Jerome Brunet (9):
  ARM64: dts: meson-gx: Use correct mmc clock source 0
  ARM64: dts: meson: remove cap-sd-highspeed from emmc nodes
  ARM64: dts: meson: add mmc clk gate pins
  ARM64: dts: meson-gxbb: nanopi-k2: add card regulator settle times
  ARM64: dts: meson-gxl: libretech-cc: add card regulator settle times
  ARM64: dts: meson-gxl: libretech-cc: remove sdr104 capability
  ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
  ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS modes
  ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode

 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 10 +++---
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 19 ++++++++---
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 12 ++++---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  9 ++---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 13 +++++---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 10 +++---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 39 ++++++++++++++++++++--
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  7 ++--
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 10 ++++--
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 10 +++---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 10 +++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 39 ++++++++++++++++++++--
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  7 ++--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |  1 -
 14 files changed, 146 insertions(+), 50 deletions(-)

-- 
2.9.5
