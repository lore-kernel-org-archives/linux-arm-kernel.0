From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 08:27:46 +0900
Subject: [PATCH v5 00/14] arm64: renesas: add sound support
Message-ID: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these patches add sound support to the r8a7795/Salvator-X.

These patches are an update of work by Kuninori Morimoto,
broken out of a larger patchset posted by him.

The main change to the patches themselves since Morimoto-san's v3 posting
and v4 updates to that posting is to update to new CPG/MSSR bindings via
Geert Uytterhoeven.

Morimoto-san, I would be most grateful if you could look over this and repost
if there are problems.

Base:

* "[PATCH v4 0/3] arm64: renesas: r8a7795: add I2C support"
  This can be found in the topic/r8a7795-i2c-v4 branch of
  my renesas tree on kernel.org.

Availability:
* This patchset is available in the  topic/r8a7795-sound-v5 branch of my
  renesas tree on kernel.org


Kuninori Morimoto (14):
  arm64: renesas: r8a7795: add AUDIO_DMAC support
  arm64: renesas: r8a7795: Sound SSI PIO support
  arm64: renesas: r8a7795: Sound SSI DMA support
  arm64: renesas: r8a7795: Sound SRC support
  arm64: renesas: r8a7795: Sound DVC support
  arm64: renesas: r8a7795: Sound CTU/MIX support
  arm64: renesas: salvator-x: Sound SSI PIO support
  arm64: renesas: salvator-x: Sound SSI DMA support
  arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
  arm64: renesas: salvator-x: Sound SRC support
  arm64: renesas: salvator-x: Sound DVC support
  arm64: defconfig: add Renesas sound and AK4613 support
  arm64: defconfig: add Renesas R-Car DMAC driver support
  arm64: defconfig: add CS2000 driver support

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 113 +++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 273 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   8 +
 3 files changed, 394 insertions(+)

-- 
2.1.4
