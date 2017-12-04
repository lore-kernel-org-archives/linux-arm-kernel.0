From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon,  4 Dec 2017 10:21:04 +0100
Subject: [RESEND PATCH v5 0/6] ARM: Add Variscite DART-MX6 SoM and
 Carrier-board support
Message-ID: <1512379270-27436-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of [5] with only changes in the SPDX-Licence-Identifier to
the top of the DTS files as required by Linus and explicited at [6].

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

PCIe, On-Board DMIC and Camera Interfaces are not handled yet.

Changes since v5 at [5]:
- Moved SPDX-Licence-Identifier to top of dts files

Changes since v4 at [4]:
- Renamed coded label
- Updated gpio wakeup properties
- Removed useless panel blank lines
- Removed leading 0 in pmic node name address
- Changed last patch title to match imx defconfig name
- Fixed dtsi alphabetical ordering

Changes since v3 at [3]:
- minor pcie dt fix
- added tags

Changes since v2 at [2]:
- Added bindings acks
- fixed enable-active-high regulators property
- moved hdmi dd-i2c-bus to son dtsi
- fixed pinmux IOMUX value
- add pcie reset-gpio

Changes since v1 at [1]:
- Add lvds display vendor prefix and bindings
- fix all gpio phandle arguments with correct ACTIVE_XXX define
- drop pcie support
- drop custom operating points
- fix arm/pu/soc vin-supply instead of &cpu node override
- fix can pinmux value
- changed button node name
- add revied-by tags on first and last patches

[1] http://lkml.kernel.org/r/1511281705-30849-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1511348560-28505-1-git-send-email-narmstrong at baylibre.com
[3] http://lkml.kernel.org/r/1511785716-23492-1-git-send-email-narmstrong at baylibre.com
[4] http://lkml.kernel.org/r/1511950857-19292-1-git-send-email-narmstrong at baylibre.com
[5] http://lkml.kernel.org/r/1512119024-521-1-git-send-email-narmstrong at baylibre.com
[6] https://marc.info/?l=linux-kernel&m=151051532322831&w=2

Neil Armstrong (6):
  ARM: dts: imx6qdl-pinfunc: Add missing
    MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT
  dt-bindings: Add vendor prefix for Solomon Goldentek Display
    Corporation
  dt-bindings: display: Add bindings for SGD GKTW70SDAE4SE Panel
  ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM support
  ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board support
  ARM: imx_v6_v7_defconfig: Add missing config for DART-MX6 SoM

 .../bindings/display/panel/sgd,gktw70sdae4se.txt   |  41 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6dl-pinfunc.h                 |   1 +
 arch/arm/boot/dts/imx6q-pinfunc.h                  |   1 +
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts     | 235 ++++++++++
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi            | 503 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   6 +
 8 files changed, 789 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
 create mode 100644 arch/arm/boot/dts/imx6q-var-dt6customboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-var-dart.dtsi

-- 
2.7.4
