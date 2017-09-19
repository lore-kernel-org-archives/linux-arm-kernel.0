From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 19 Sep 2017 16:53:38 +0200
Subject: [PATCH 0/2] ARM64: meson-gxm: Add support for Khadas VIM2
Message-ID: <1505832820-3517-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Khadas VIM2 is a Single Board Computer, respin of the origin
Khadas VIM board, using an Amlogic S912 SoC and more server oriented.
    
It provides the same external connectors and header pinout, plus a SPI
NOR Flash, a reprogrammable STM8S003 MCU, FPC Connector, Cooling FAN header
and Pogo Pads Arrays.

To eventually provide access to the SPI NOR flash, the eMMC DS pin must be
configured as a different pincrl node to disable it's access from the MMC
Controller. This first patch splits this emmc pins entry for GXBB and GXL.

Neil Armstrong (2):
  ARM64: dts: meson-gxl: Take eMMC data strobe out of eMMC pins
  ARM64: dts: meson-gxm: Add support for Khadas VIM2

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   2 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |   2 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   2 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  10 +-
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |   2 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   2 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |   2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  10 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 401 +++++++++++++++++++++
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |   2 +-
 17 files changed, 431 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts

-- 
1.9.1
