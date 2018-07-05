From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  5 Jul 2018 11:50:41 +0200
Subject: [PATCH 0/2] Add support for S805X based P241 Reference Design board
Message-ID: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic P241 board is the Reference Design board for the S805X
variant of the Amlogic Meson GXL SoC family.

The S805X is a variant of the Amlogic Meson GXL SoC family with the
following physical limitations :
- No SDCard interface
- No GPIOCLK pins
- No USB OTG ID pin (but Gadget feature can stil be forced)
- No 5V regulator
- Reduced ADC inputs (only ADC0 and ADC1)
- GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
  GPIOX_15, GPIOH_3 are no more exposed on the package

Amlogic exposes the following SW limitations :
- HDMI max resolution should be 1080p60, VPU clock should be downgraded
- Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
- CPU speed should be limited by SCPI OPP table to 1.2GHz
- DRAM interface is limited to DDR4 16bit up to 1GiB

The P241 board has the following features :
- 1GiB DDR4 Memory
- HDMI Connector with CEC
- A/V jack with Stereo Audio and CVBS
- 10/100 Ethernet
- 2x USB2.0 Type-A
- On-board WiFi SDIO Module
- On-board eMMC storage
- Infraread Received
- Factory Reset button
- UART connector

Neil Armstrong (2):
  dt-bindings: amlogic: Add support for GXL S805X and the P241 board
  ARM64: dts: add S805X based P241 board

 Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      | 218 +++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts

-- 
2.7.4
