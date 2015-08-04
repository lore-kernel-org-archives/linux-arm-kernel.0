From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue,  4 Aug 2015 13:18:15 +0200
Subject: [PATCH v2 0/4] Add SPDIF support for rockchip
Message-ID: <1438687099-14282-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Rockchip SPDIF transceiver as present
on RK3066, RK3188 and RK3288 boards and enables it on a Radxa rock pro.
Tested on a Radxa Rock Pro board.

Changes in v2:
- Remove platform: module alias as it was unused
- Call MODULE_DEVICE_TABLE(of, ) right after the of match table
- use rk_spdif as a prefix consistenly throughout the driver
- Check return code of regmap_update and bubble it up
- Sort the spdif node properties
- Drop the 0x prefix from the node name
- Rename the spdif@ node to sound@

Sjoerd Simons (4):
  ASoC: dt-bindings: add rockchip tranceiver bindings
  ASoc: rockchip: Add rockchip SPDIF transceiver driver
  ARM: dts: rockchip: Add SPDIF transceiver for RK3188
  ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock

 .../devicetree/bindings/sound/rockchip-spdif.txt   |  41 +++
 arch/arm/boot/dts/rk3188-radxarock.dts             |  19 +
 arch/arm/boot/dts/rk3188.dtsi                      |  22 ++
 sound/soc/rockchip/Kconfig                         |   8 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_spdif.c                | 381 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.h                |  63 ++++
 7 files changed, 536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
 create mode 100644 sound/soc/rockchip/rockchip_spdif.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.h

-- 
2.5.0
