From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 17:44:38 +0100
Subject: [PATCH 0/8] ARM64: dts: meson-gxl: Add extended support
Message-ID: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provides extended peripheral support for the Amlogix GXL SoCs.

In order to support more functionalities, this patchset :
 - Moves peripheral nodes to the common Meson arm64 dtsi
 - Add i2c, mmc, sd, sdio, pinctrl and clock nodes for GXL
 - Adds correct GXL P23X boards uart pinctrl
 - Add SD/MMC and SDIO WiFi support support for P23X boards

This patchset depends on pinctrl patch at [1] and the dt-include file :
include/dt-bindings/gpio/meson-gxl-gpio.h

Changes since original RFC patchset at : [2]
 - Rebased on v4.10/dt64 at [3] commit b2ac270c3836 ("ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes")

[1] http://lkml.kernel.org/r/1477931531-27120-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1477060838-14164-1-git-send-email-narmstrong at baylibre.com
[3] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git

Neil Armstrong (8):
  ARM64: dts: meson-gxbb: Move common nodes to meson-gx
  ARM64: dts: meson-gxl: Add pinctrl nodes
  ARM64: dts: meson-gxl: Add clock nodes
  ARM64: dts: meson-gxl: Add i2c nodes
  ARM64: dts: meson-gxl: Add MMC/SD/SDIO nodes
  ARM64: dts: meson-gxl-p23x: Add uart pinctrl
  ARM64: dts: meson-gxl-p23x: Add SD/SDIO/MMC and PWM nodes
  ARM64: dts: meson-gxl-p23x: Enable IR receiver

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 131 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 153 ++-------------
 .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     | 121 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 210 +++++++++++++++++++++
 4 files changed, 479 insertions(+), 136 deletions(-)

-- 
1.9.1
