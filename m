From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:10 +0200
Subject: [PATCH v2 0/9] DT instantiation of sound on T5325
Message-ID: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset uses DT to instantiate sound on the T5325. It adds a DT
binding to the codec, then removes the platform device for the codec
and adds a DT node. simple-card is extended to support mlck_fs. The
platform device for the audio device is then replaced with a DT node.
Lastly, two _defconfig's are updated to build the needed modules.

Andrew Lunn (9):
  ASoC: alc5623: Add device tree binding
  ARM: Kirkwood: Remove platform driver for codec
  ARM: Kirkwood: Add node for audio codec
  ARM: Kirkwood: DT: Add missing #sound-dai-cells property
  ASoC: simple-card: Support setting mclk via a fixed factor
  ARM: Kirkwood: t5325: Remove platform device to instantiate audio
  ARM: Kirkwood: t5325: Use simple card to instantiate audio
  ARM: mvebu_v5_defconfig: Enable sound modules needed for t5325
  ARM: multi_v5_defconfig: Enable sound modules needed for t5325

 .../devicetree/bindings/sound/alc5623.txt          | 25 +++++++++++++
 .../devicetree/bindings/sound/simple-card.txt      |  2 ++
 arch/arm/boot/dts/kirkwood-t5325.dts               | 33 +++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |  1 +
 arch/arm/configs/multi_v5_defconfig                |  3 +-
 arch/arm/configs/mvebu_v5_defconfig                |  3 +-
 arch/arm/mach-mvebu/Kconfig                        |  7 ----
 arch/arm/mach-mvebu/Makefile                       |  1 -
 arch/arm/mach-mvebu/board-t5325.c                  | 41 ----------------------
 arch/arm/mach-mvebu/board.h                        |  6 ----
 arch/arm/mach-mvebu/kirkwood.c                     |  3 --
 sound/soc/codecs/Kconfig                           |  2 +-
 sound/soc/codecs/alc5623.c                         | 20 +++++++++++
 sound/soc/generic/simple-card.c                    | 28 +++++++++++++++
 14 files changed, 114 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 delete mode 100644 arch/arm/mach-mvebu/board-t5325.c

-- 
2.0.0.rc0
