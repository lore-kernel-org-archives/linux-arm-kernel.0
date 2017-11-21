From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Nov 2017 17:28:21 +0100
Subject: [PATCH 0/4] ARM: Add Variscite DART-MX6 SoM and Carrier-board support
Message-ID: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Variscite DART-MX6 SoM with :
- i.MX6 Quad or Dual Lite SoC
- 1Gb/2Gb LPDDR2
- 4-64 GB eMMC
- Camera Interface
- HDMI+CEC interface
- LVDS / DSI / Parallel RGB interfaces
- Ethernet RGMII interface
- On-SoM Wi-Fi/Bluetooth with WiLink wl1835 SDIO Module
- SD/MMC/SDIO interface
- USB Host + USB OTG interface
- I2C interfaces
- SPI interfaces
- PCI-Express 2.0 interface
- on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
- Digital Audio interface
- S/PDIF interface

And the Carrier-Board with the following :
- LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
- HDMI Connector
- USB Host + USB OTG Connector
- 10/100/1000 Mbps Ethernet
- miniPCI-Express slot
- SD Card connector
- Audio Headphone/Line In jack connectors
- On-board DMIC
- CAN bus header
- SPI header
- Camera Interfaces header
- 4xButtons, 2xLeds
- OnBoard RTC with Coin Backup battery socket
- RS232 Header + USB-Serial debug port

First patch contains a missing pinmux define used by the SoM.
Last patch contains configs used by the SoM DT like SERDEV or WL18XX support.

On-Board DMIC and Camera Interfaces are not handled yet.

Neil Armstrong (4):
  ARM: dts: imx6qdl-pinfunc: Add missing
    MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT
  ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM support
  ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board support
  ARM: configs: Add missing config for DART-MX6 SoM

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/imx6dl-pinfunc.h             |   1 +
 arch/arm/boot/dts/imx6q-pinfunc.h              |   1 +
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts | 247 ++++++++++++
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi        | 510 +++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig           |   6 +
 6 files changed, 766 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-var-dt6customboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-var-dart.dtsi

-- 
2.7.4
