From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon,  7 Nov 2016 11:43:54 +0100
Subject: [PATCH 0/3] ARM64: dts: meson-gxl: Enable Ethernet
Message-ID: <20161107104357.24428-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXL SoCs have an internal RMII PHY that is muxed with the
external RGMII pins.

The internal PHY is added in the GXL dtsi and support for each
board is added in intermediate board family dtsi or final dts.

This patchset depends on ARM64 dts patch at [1]

Changes since v2 RFC at : [3]
 - Change phy Kconfig/Makefile alphabetic order
 - GXL dtsi cleanup
 - Add P230 External PHY reset
 - Add external PHY compatible ID string

Changes since original RFC patchset at : [2]
 - Remove meson8b experimental phy switching
 - Switch to mdio-mux-mmioreg with extennded size support
 - Add internal phy support for S905x and p231
 - Add external PHY support for p230

[1] http://lkml.kernel.org/r/1477932286-27482-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1477060838-14164-1-git-send-email-narmstrong at baylibre.com
[3] http://lkml.kernel.org/r/1477932987-27871-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (3):
  ARM64: dts: meson-gxl: Add ethernet nodes with internal PHY
  ARM64: dts: meson-gxl-p23x: Enable ethernet
  ARM64: dts: meson-gxl-s905x: Enable internal ethernet PHY

 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      | 25 +++++++++++++
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  6 +++
 .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |  6 +++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 43 ++++++++++++++++++++++
 5 files changed, 84 insertions(+)

-- 
2.7.0
