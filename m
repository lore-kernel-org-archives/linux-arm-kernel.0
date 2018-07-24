From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 15:15:36 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.19
Message-ID: <20180724131536.iompsqlrpjsvf5uy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.19

for you to fetch changes up to ecbd611882a18cc5e720e752cae92d1198b198ec:

  arm64: allwinner: h6: enable MMC0/2 on Pine H64 (2018-07-19 16:50:33 +0200)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.19

Some interesting changes, especially:

  - MMC support for the H6
  - PMIC support for the PineH64
  - HDMI simplefb support for the A64
  - PWM support for the A64
  - New board: Pinebook, Amarula A64-Relic

----------------------------------------------------------------
Andre Przywara (1):
      arm64: dts: allwinner: a64: Add PWM controllers

Chen-Yu Tsai (2):
      arm64: dts: allwinner: h6: Add LED device nodes for Pine H64
      arm64: dts: allwinner: h6: Use macros for R_CCU clock and reset indices

Corentin Labbe (1):
      arm64: dts: allwinner: a64: Remove unused address-cells/size-cells of dwmac-sun8i

Emmanuel Vadot (3):
      arm64: dts: allwinner: sun50i: a64: Add spi flash node for sopine
      arm64: dts: allwinner: sun50i: h5: Add spi flash node for OrangePi PC2
      arm64: allwinner: a64-sopine: Add cd-gpios to mmc0 node

Icenowy Zheng (12):
      arm64: dts: allwinner: a64: add R_I2C controller
      arm64: dts: allwinner: add support for Pinebook
      arm64: dts: allwinner: a64: add SRAM controller device tree node
      arm64: allwinner: a64: change TERES-I DLDO3's name to start with "vdd"
      arm64: allwinner: a64: allow laptops to wake up from lid
      arm64: dts: allwinner: a64: add necessary device tree nodes for DE2 CCU
      arm64: dts: allwinner: a64: add device tree node for HDMI simplefb
      arm64: dts: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi
      arm64: dts: allwinner: h6: enable AXP805 PMIC on Pine H64
      dt-binding: mmc: sunxi: add H6 compatible (with A64 fallback)
      arm64: allwinner: h6: add device tree nodes for MMC controllers
      arm64: allwinner: h6: enable MMC0/2 on Pine H64

Jagan Teki (3):
      arm64: allwinner: a64: Add Amarula A64-Relic initial support
      arm64: allwinner: a64: Add RTC clock to phandle 32kHz external oscillator
      arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi support

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   2 +
 arch/arm64/boot/dts/allwinner/Makefile             |   2 +
 .../dts/allwinner/sun50i-a64-amarula-relic.dts     | 219 ++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |   4 +
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |   4 +
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |   4 +
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |   4 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   4 +
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 285 +++++++++++++++++++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |   4 +
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |  15 ++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      |   7 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 113 +++++++-
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  12 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 146 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |  67 ++++-
 16 files changed, 878 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/b606249a/attachment.sig>
