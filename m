From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 12 Feb 2018 19:28:46 +0800
Subject: [PATCH v3 0/5] switch to MFD device for MediaTek audio subsystem
Message-ID: <cover.1518424204.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series switches the clock driver to adapt the new MFD parent.
I still keep the previous version of the bindings (patch 4/5) for discussion.

Rob, let me know if there is any problem with this.

changes since v3:
 - Rebase to v4.16.
 - Modify clock driver for the sake of the backward compatibility.
 - Rewrite commit message of patch 4/5 to make it more specific.

changes since v2:
 - Drop useless changes in clk-mt7622-aud.c.
 - Revise binding text: 
	- Add more information about audio subsystem.
	- Separate clock node and AFE node.
 - Update license header.

changes since v1:
 - To avoid writing an MFD driver, we add "simple-mfd" in the audsys binding.
 - Move three top clocks to audio driver [1] as we remove mfd/mtk-audsys.c in v1.

Ryder Lee (5):
  clk: mediatek: update missing clock data for MT7622 audsys
  clk: mediatek: modify MT7622 audsys to adapt MFD device
  clk: mediatek: add audsys support for MT2701
  dt-bindings: clock: mediatek: update audsys documentation to adapt MFD
    device
  arm: dts: mediatek: add audio-subsystem node for both MT2701 and
    MT7623

 .../bindings/arm/mediatek/mediatek,audsys.txt      |  37 +++-
 arch/arm/boot/dts/mt2701.dtsi                      | 192 ++++++++++----------
 arch/arm/boot/dts/mt7623.dtsi                      | 193 ++++++++++-----------
 drivers/clk/mediatek/Kconfig                       |   6 +
 drivers/clk/mediatek/Makefile                      |   1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              | 179 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |   8 +-
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 8 files changed, 414 insertions(+), 205 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c

-- 
1.9.1
