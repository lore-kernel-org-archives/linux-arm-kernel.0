From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 03 Oct 2017 17:46:03 +0200
Subject: [PATCH v2 0/2] ARM64: meson-gxm: Add support for Khadas VIM2
In-Reply-To: <1507044283-18476-1-git-send-email-narmstrong@baylibre.com>
References: <1507044283-18476-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1507045563.17300.180.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-03 at 17:24 +0200, Neil Armstrong wrote:
> The Khadas VIM2 is a Single Board Computer, respin of the origin
> Khadas VIM board, using an Amlogic S912 SoC and more server oriented.
>     
> It provides the same external connectors and header pinout, plus a SPI
> NOR Flash, a reprogrammable STM8S003 MCU, FPC Connector, Cooling FAN header
> and Pogo Pads Arrays.
> 
> To eventually provide access to the SPI NOR flash, the eMMC DS pin must be
> configured as a different pincrl node to disable it's access from the MMC
> Controller. This first patch splits this emmc pins entry for GXBB and GXL.
> 
> Depends on eMMC ARM64 DT patches from Jerome Brunet at [2]
> 
> Changes since v1 at [1] :
>  - Add acks from Martin and Rob
>  - Cleanup external_phy node
>  - Cleanup sd_emmc_a node
>  - Rebased with eMMC ARM64 DT patches from Jerome Brunet at [2]
> 
> [1] https://lkml.kernel.org/r/1505832820-3517-1-git-send-email-narmstrong at bayl
> ibre.com
> [2] https://lkml.kernel.org/r/20170831135226.19784-1-jbrunet at baylibre.com
> 
> Neil Armstrong (2):
>   ARM64: dts: meson-gxl: Take eMMC data strobe out of eMMC pins
>   ARM64: dts: meson-gxm: Add support for Khadas VIM2

For the series:

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

> 
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   2 +-
>  .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |   2 +-
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   2 +-
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   2 +-
>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |   2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  10 +-
>  .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |   2 +-
>  .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   2 +-
>  .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |   2 +-
>  .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |   2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  10 +-
>  .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 399
> +++++++++++++++++++++
>  .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |   2 +-
>  17 files changed, 429 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> 
