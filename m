From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 31 Jan 2018 15:42:40 +0800
Subject: [PATCH v2 0/5] add MFD support for MediaTek audio subsystem
Message-ID: <cover.1515639336.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the 2nd version of the patch sets which modify clock driver to adapt
audio subsystem.  I still keeping 'simple-mfd' in the binding for discussion.
Rob, let me know if there is any problem with this.

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
 drivers/clk/mediatek/clk-mt2701-aud.c              | 175 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt7622-aud.c              |   4 +-
 include/dt-bindings/clock/mt7622-clk.h             |   3 +-
 8 files changed, 406 insertions(+), 205 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c

-- 
1.9.1
